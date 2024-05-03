using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.IO;
using System.Threading.Tasks;
using TXAPI.Models.File;

namespace TXAPI.Services.FileUpload
{
	public class FileService : IFileService
	{
		private IConfiguration _config;

		public FileService(IConfiguration config)
		{
			_config = config;
		}

		public async Task<byte[]> GetBinary(string filePath)
		{
			string contentRootPath = _config["AvatarPath"];
			string fullPath = Path.Combine(contentRootPath, filePath);

			try
			{
				if (!System.IO.File.Exists(fullPath)) return null;
				using (FileStream fileStream = new FileStream(filePath, FileMode.Open))
				{
					using (var memoryStream = new MemoryStream())
					{
						await fileStream.CopyToAsync(memoryStream);
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

		public bool Remove(string filePath)
		{
			string contentRootPath = _config["AvatarPath"];
			string fullPath = Path.Combine(contentRootPath, filePath);
			try
			{
				if (File.Exists(fullPath))
				{
					File.Delete(fullPath);
				}
				return true;
			}
			catch
			{
				return false;
			}
		}

		public async Task<IList<FileInfoModel>> Save(IFormFileCollection files, string folder)
		{
			try
			{
				var list = new List<FileInfoModel>();

				string contentRootPath = _config["AvatarPath"];

				string folderPath = Path.Combine(contentRootPath, folder);

				if (!Directory.Exists(folderPath))
				{
					Directory.CreateDirectory(folderPath);
				}

				foreach (var file in files)
				{
					string fileName = $"{DateTime.Now.ToString("ddMMyyyyhhmmss")}-{file.FileName}";
					string filePath = Path.Combine(folderPath, fileName);
					using (var memoryStream = File.Create(filePath))
					{
						await file.CopyToAsync(memoryStream);
					}
					list.Add(new FileInfoModel
					{
						Name = file.Name,
						Path = Path.Combine(folder, fileName),
						Type = file.ContentType
					});
				}

				return list;
			}
			catch (Exception e)
			{
				throw;
			}
		}

		public string ReFileName(string oldFullFileName, string newFileName)
		{
			try
			{
				string oldfileName = Path.GetFileNameWithoutExtension(oldFullFileName);
				return oldFullFileName.Replace(oldfileName, newFileName);
			}
			catch
			{
				return oldFullFileName;
			}
		}
	}
}
