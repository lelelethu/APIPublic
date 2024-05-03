using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.StaticFiles;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using TXAPI.Common;
using TXAPI.ModelBase;
using TXAPI.Models;
using TXAPI.Services.FileUpload;

namespace TXAPI.Controllers
{

	[Route("api/files")]
	[ApiController]
	public class UploadFileController : BaseApiController
	{
		private readonly IWebHostEnvironment _webHostEnvironment;
		private readonly IAppSetting _appSetting;
		private readonly IFileService _fileService;
		private readonly IFileService _uploadService;

		public UploadFileController(IWebHostEnvironment webHostEnvironment, IAppSetting appSetting, IFileService fileService)
		{
			_webHostEnvironment = webHostEnvironment;
			_appSetting = appSetting;
			_fileService = fileService;
		}


		[HttpPost]
		[Route("UploadScreenShotSingle")]
		[Authorize]
		public async Task<ActionResult<object>> UploadScreenShotSingle(IFormFile file, [FromForm] string WebName, [FromForm] string GameName)
		{
			try
			{
				string[] _supported = { ".png", ".jpg", ".jpeg", ".gif", ".bmp", ".tga", ".tif", ".tiff", ".pbm" };
				string extstr = Path.GetExtension(file.FileName).ToLowerInvariant();

				if (!_supported.Contains(extstr))
				{
					return new Models.Results.ResultApi { Success = ResultCode.ERROR, Message = string.Format(MessageInfo.File_UploadImage_NotSupport, extstr) };
				}

				var keyClaim = HttpContext.User.FindFirst("Key");
				string key = keyClaim.Value;
				if (file == null)
				{
					return new Models.Results.ResultApi { Success = ResultCode.ERROR, Message = MessageInfo.File_UploadImage_FileNotFound };
				}

				string contentRootPath = _webHostEnvironment.ContentRootPath;
				string folderName = UploadFolder.Image + WebName + Path.DirectorySeparatorChar + GameName + Path.DirectorySeparatorChar + DateTime.Now.ToString("yyyyMMdd") + Path.DirectorySeparatorChar + key;
				string folderPath = Path.Combine(contentRootPath, folderName);
				if (!Directory.Exists(folderPath))
				{
					Directory.CreateDirectory(folderPath);
				}

				string fileNamePath = Path.Combine(folderPath, file.FileName);
				using (var memoryStream = System.IO.File.Create(fileNamePath))
				{
					await file.CopyToAsync(memoryStream);
				}

				return new Models.Results.ResultApi { Success = ResultCode.OK };
			}
			catch (Exception e)
			{
				return new Models.Results.ResultApi { Success = ResultCode.ERROR, Message = e.Message };
			}
		}

		[HttpPost]
		[Route("UploadScreenShot")]
		[Authorize]
		public async Task<ActionResult<object>> UploadScreenShot(List<IFormFile> files, [FromForm] string WebName, [FromForm] string GameName, [FromForm] long? GameId)
		{
			try
			{
				string[] _supported = { ".png", ".jpg", ".jpeg", ".gif", ".bmp", ".tga", ".tif", ".tiff", ".pbm" };
				foreach (var file in files)
				{
					string extstr = Path.GetExtension(file.FileName).ToLowerInvariant();

					if (!_supported.Contains(extstr))
					{
						return new Models.Results.ResultApi { Success = ResultCode.ERROR, Message = string.Format(MessageInfo.File_UploadImage_NotSupport, extstr) };
					}
				}

				var userIdClaim = HttpContext.User.FindFirst("UserId");
				int userId = Int32.Parse(userIdClaim.Value);
				var keyClaim = HttpContext.User.FindFirst("Key");
				string key = keyClaim.Value;
				var keyIdClaim = HttpContext.User.FindFirst("KeyId");
				int keyId = Int32.Parse(keyIdClaim.Value);
				var uniqueDeviceIdClaim = HttpContext.User.FindFirst("UniqueDeviceId");
				string uniqueDeviceId = uniqueDeviceIdClaim.Value;

				if (files == null || files.Count <= 0)
				{
					return new Models.Results.ResultApi { Success = ResultCode.ERROR, Message = MessageInfo.File_UploadImage_FileNotFound };
				}

				//Lưu log
				UploadScreenShotInput uploadScreenShotInput = new UploadScreenShotInput
				{
					WebName = WebName,
					GameName = GameName,
				};
				UploadScreenShotLog uploadScreenShotLog = new UploadScreenShotLog
				{
					DatetimeAction = DateTime.Now,
					Key = key,
					UserId = userId,
					UniqueDeviceId = uniqueDeviceId,
					UploadScreenShotInput = uploadScreenShotInput
				};
				FuncFile.WriteLog<UploadScreenShotLog>(uploadScreenShotLog, _webHostEnvironment, "UploadScreenShotLog.txt", key, WebName, GameName);

				string contentRootPath = _webHostEnvironment.ContentRootPath;
				string folderName = UploadFolder.Image + WebName + Path.DirectorySeparatorChar + GameName + Path.DirectorySeparatorChar + DateTime.Now.ToString("yyyyMMdd") + Path.DirectorySeparatorChar + key;
				string folderPath = Path.Combine(contentRootPath, folderName);
				if (!Directory.Exists(folderPath))
				{
					Directory.CreateDirectory(folderPath);
				}

				foreach (var file in files)
				{
					string fileNamePath = Path.Combine(folderPath, file.FileName);
					using (var memoryStream = System.IO.File.Create(fileNamePath))
					{
						await file.CopyToAsync(memoryStream);
					}

					try
					{
						//Insert vào DB bảng chứa ảnh game
						//Lấy gameid
						if (GameId == null)
						{
							string fileNameWithoutExtension = Path.GetFileNameWithoutExtension(file.FileName);
							int lastUnderscoreIndex = fileNameWithoutExtension.LastIndexOf('_');
							GameId = long.Parse(fileNameWithoutExtension.Substring(lastUnderscoreIndex + 1));
						}
						APUserKeyHistoryImageInsertIN _aPUserKeyHistoryImageInsertIN = new APUserKeyHistoryImageInsertIN
						{
							WebName = WebName,
							GameName = GameName,
							UserId = userId,
							KeyId = keyId,
							GameId = GameId,
							Image = file.FileName,
						};
						await new APUserKeyHistoryImageInsert(_appSetting).APUserKeyHistoryImageInsertDAO(_aPUserKeyHistoryImageInsertIN);
					}
					catch (Exception ex)
					{
						APErrorInsertIN _aPErrorInsertIN = new APErrorInsertIN
						{
							WebName = WebName,
							GameName = GameName,
							UserId = userId,
							KeyId = keyId,
							UniqueDeviceId = uniqueDeviceId,
							APIName = "UploadScreenShot",
							Request = string.Empty,
							ErrorMessage = ex.Message
						};
						await new APErrorInsert(_appSetting).APErrorInsertDAO(_aPErrorInsertIN);
					}
				}

				return new Models.Results.ResultApi { Success = ResultCode.OK };
			}
			catch (Exception e)
			{
				return new Models.Results.ResultApi { Success = ResultCode.ERROR, Message = e.Message };
			}
		}
		//[HttpGet]
		//[Route("DownLoadFileNew")]
		//[AllowAnonymous]
		//public async Task<IActionResult> DownLoadFileNew(string name)
		//{
		//	var fileName = System.IO.Path.GetFileName(name);
		//	var content = await System.IO.File.ReadAllBytesAsync(name);
		//	new FileExtensionContentTypeProvider()
		//		.TryGetContentType(fileName, out string contentType);
		//	return File(content, contentType, fileName);

		//	//var stream = new MemoryStream();
		//	//// processing the stream.
		//	//using (FileStream fileStream = new FileStream(name, FileMode.Open))
		//	//{
		//	//	await fileStream.CopyToAsync(stream);
		//	//	return File(stream, "application/octet-stream", Path.GetFileName(name)); // returns a FileStreamResult
		//	//}
		//}

		//[HttpGet]
		//[Route("DownloadBin")]
		//public async Task<byte[]> DownloadBin(string path)
		//{
		//	Base64EncryptDecryptFile decrypt = new Base64EncryptDecryptFile();
		//	var filePath = decrypt.DecryptData(path);

		//	byte[] bin = await _fileService.GetBinary(filePath);

		//	return bin;
		//}

		//[HttpPost]
		//[AllowAnonymous]
		//[Route("DownloadFile")]
		//public async Task<IActionResult> DownloadFile([FromForm] string path)
		//{
		//	Base64EncryptDecryptFile decrypt = new Base64EncryptDecryptFile();
		//	var filePath = decrypt.DecryptData(path);

		//	byte[] bin = await _fileService.GetBinary(filePath);
		//	return new FileContentResult(bin, "application/octet-stream");
		//}

		//[HttpPost]
		//[AllowAnonymous]
		//[Route("DownloadFile")]
		//public async Task<IActionResult> DownloadFile([FromForm] string path)
		//{
		//	Base64EncryptDecryptFile decrypt = new Base64EncryptDecryptFile();
		//	var filePath = decrypt.DecryptData(path);

		//	byte[] bin = await _fileService.GetBinary(filePath);
		//	return new FileContentResult(bin, "application/octet-stream");
		//}

		private async Task<byte[]> getFileBin(string filePath)
		{
			string contentRootPath = _webHostEnvironment.ContentRootPath;
			string fullPath = Path.Combine(contentRootPath, filePath);

			try
			{
				using (FileStream fileStream = new FileStream(filePath, FileMode.Open))
				{
					using (var memoryStream = new MemoryStream())
					{
						await fileStream.CopyToAsync(memoryStream);
						Bitmap image = new Bitmap(1, 1);
						image.Save(memoryStream, ImageFormat.Jpeg);

						byte[] byteImage = memoryStream.ToArray();
						return byteImage;
					}
				}
			}
			catch
			{
				return null;
			}
		}

		private async Task<byte[]> getFileBinNew(string filePath)
		{
			string contentRootPath = _webHostEnvironment.ContentRootPath;
			string fullPath = Path.Combine(contentRootPath, filePath);

			try
			{
				using (FileStream fileStream = new FileStream(filePath, FileMode.Open))
				{
					using (var memoryStream = new MemoryStream())
					{
						await fileStream.CopyToAsync(memoryStream);
						Bitmap image = new Bitmap(1, 1);
						image.Save(memoryStream, ImageFormat.Jpeg);

						byte[] byteImage = memoryStream.ToArray();
						return byteImage;
					}
				}
			}
			catch
			{
				return null;
			}
		}
	}
}
