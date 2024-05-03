using DocumentFormat.OpenXml.Wordprocessing;
using ImageMagick;
using Microsoft.AspNetCore.Hosting;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Drawing.Imaging;
using System.Globalization;
using System.IO;
using System.Text;
using TXAPI.Controllers;

namespace TXAPI.Common
{
	public static class FuncFile
	{
		public static void WriteLog<T>(T logData, IWebHostEnvironment _webHostEnvironment, string fileName, string Key, string WebName, string GameName, string gamelink = null)
		{
			//Lưu log
			string contentRootPath = _webHostEnvironment.ContentRootPath;

			if (string.IsNullOrEmpty(gamelink))
			{
				if (WebName != null && GameName != null)
				{
					gamelink = WebName + Path.DirectorySeparatorChar + GameName + Path.DirectorySeparatorChar;
				}
				else
				{
					gamelink = gamelink + Path.DirectorySeparatorChar;
				}
			}

			string folderName = UploadFolder.Log + gamelink + DateTime.Now.ToString("yyyyMMdd") + Path.DirectorySeparatorChar + Key;
			string folderPath = Path.Combine(contentRootPath, folderName);
			string path = folderPath + Path.DirectorySeparatorChar + fileName;
			try
			{
				if (!Directory.Exists(folderPath))
				{
					Directory.CreateDirectory(folderPath);
				}
				List<T> listinput = new List<T>();
				if (System.IO.File.Exists(path))
				{
					string tmp = System.IO.File.ReadAllText(path);
					listinput = JsonConvert.DeserializeObject<List<T>>(tmp);
				}
				dynamic dynamicLogData = logData;

				listinput.Add(dynamicLogData);
				System.IO.File.WriteAllText(path, JsonConvert.SerializeObject(listinput, Formatting.Indented));
			}
			catch (Exception ex)
			{
				//Nếu bị lỗi thì xóa luôn path
				if (System.IO.File.Exists(path))
				{
					System.IO.File.Delete(path);
				}
			}
		}

		public static ResponseFileInfo ConvertExtAndCompress(string filename, string ext, string newtext, int? height, int? width)
		{
			if (ext != newtext)
			{
				string newfile = ChangeName(filename, ext, newtext);
				using (MagickImage image = new MagickImage(filename))
				{
					image.Format = image.Format;

					if (height != null || width != null)
					{
						if (height == null || height == 0)
						{
							height = image.Height;
						}
						if (width == null || width == 0)
						{
							width = image.Width;
						}
						var size = new MagickGeometry(width.Value, height.Value);
						size.IgnoreAspectRatio = true;
						image.Resize(size);
					}
					image.Quality = 10; // This is the Compression level.
					image.Depth = 16;
					image.Write(Path.Combine(newfile));
					if (File.Exists(filename))
					{
						File.Delete(filename);
					}
					return new ResponseFileInfo { Name = newfile, Size = new FileInfo(newfile).Length };
				}
			}
			return null;
		}

		public static string ChangeName(string filename, string ext, string newtext)
		{
			string onlyFile = filename.Substring(0, filename.Length - ext.Length);
			return onlyFile + "." + newtext;
		}

		public static ImageFormat GetImageFormat(string fileName)
		{
			string extension = Path.GetExtension(fileName);
			if (string.IsNullOrEmpty(extension))
				throw new ArgumentException(
					string.Format("Unable to determine file extension for fileName: {0}", fileName));

			switch (extension.ToLower())
			{
				case @".bmp":
					return ImageFormat.Bmp;

				case @".gif":
					return ImageFormat.Gif;

				case @".ico":
					return ImageFormat.Icon;

				case @".jpg":
				case @".jpeg":
					return ImageFormat.Jpeg;

				case @".png":
					return ImageFormat.Png;

				case @".tif":
				case @".tiff":
					return ImageFormat.Tiff;

				case @".wmf":
					return ImageFormat.Wmf;

				case @".webp":
					return ImageFormat.Webp;

				case @".exif":
					return ImageFormat.Exif;
				default:
					throw new NotImplementedException();
			}
		}

		private static System.Drawing.Size CalculateDimensions(System.Drawing.Size oldSize, int targetSize)
		{
			System.Drawing.Size newSize = new System.Drawing.Size();
			if (oldSize.Height > oldSize.Width)
			{
				newSize.Width = (int)(oldSize.Width * ((float)targetSize / (float)oldSize.Height));
				newSize.Height = targetSize;
			}
			else
			{
				newSize.Width = targetSize;
				newSize.Height = (int)(oldSize.Height * ((float)targetSize / (float)oldSize.Width));
			}
			return newSize;
		}

		private static string GetArguments(string sourceFile, string targetFile, bool lossy)
		{
			//If dont have folder then create first
			if (!Directory.Exists(Path.GetDirectoryName(targetFile)))
			{
				Directory.CreateDirectory(Path.GetDirectoryName(targetFile));
			}

			if (!Uri.IsWellFormedUriString(sourceFile, UriKind.RelativeOrAbsolute) && !File.Exists(sourceFile))
				return null;

			string ext;

			try
			{
				ext = Path.GetExtension(sourceFile).ToLowerInvariant();
			}
			catch (ArgumentException ex)
			{
				System.Diagnostics.Debug.Write(ex);
				return null;
			}

			switch (ext)
			{
				case ".png":
					if (!File.Exists(targetFile))
					{
						File.Copy(sourceFile, targetFile);
					}

					if (lossy)
						return string.Format(CultureInfo.CurrentCulture, "/c pingo -s8 -pngpalette=79 -q \"{0}\"", targetFile);
					else
						return string.Format(CultureInfo.CurrentCulture, "/c pingo -s8 -pngpalette=79 -q \"{0}\"", targetFile);
				//return string.Format(CultureInfo.CurrentCulture, "/c pingo -auto=100 -s8 -q \"{0}\"", targetFile);

				case ".jpg":
				case ".jpeg":
					if (lossy)
						return string.Format(CultureInfo.CurrentCulture, "/c cjpeg -quality 80,60 -dct float -smooth 5 -outfile \"{1}\" \"{0}\"", sourceFile, targetFile);
					else
						return string.Format(CultureInfo.CurrentCulture, "/c jpegtran -copy none -optimize -progressive -outfile \"{1}\" \"{0}\"", sourceFile, targetFile);
				//return string.Format(CultureInfo.CurrentCulture, "/c guetzli_windows_x86-64 \"{0}\" \"{1}\"", sourceFile, targetFile);

				case ".gif":
					return string.Format(CultureInfo.CurrentCulture, "/c gifsicle -O3 \"{0}\" --output=\"{1}\"", sourceFile, targetFile);
			}

			return null;
		}

		public static string GetFileNameFromPath(string sourceFile)
		{
			var list0 = sourceFile.Split('\\');
			string fileName = list0[list0.Length - 1];

			return fileName;
		}

	}

	public class ImageCompressionResult
	{
		public ImageCompressionResult(string originalFileName, string resultFileName, TimeSpan elapsed)
		{
			Elapsed = elapsed;
			var original = new FileInfo(originalFileName);
			var result = new FileInfo(resultFileName);

			if (original.Exists)
			{
				OriginalFileName = original.FullName;
				OriginalFileSize = original.Length;
			}

			if (result.Exists)
			{
				ResultFileName = result.FullName;
				ResultFileSize = result.Length;
			}

			Processed = true;
		}

		public long OriginalFileSize { get; set; }
		public string OriginalFileName { get; set; }
		public long ResultFileSize { get; set; }
		public string ResultFileName { get; set; }
		public bool Processed { get; set; }
		public TimeSpan Elapsed { get; set; }

		public long Saving
		{
			get { return Math.Max(OriginalFileSize - ResultFileSize, 0); }
		}

		public double Percent
		{
			get
			{
				return Math.Round(100 - (double)ResultFileSize / (double)OriginalFileSize * 100, 1);
			}
		}

		public override string ToString()
		{
			var sb = new StringBuilder();
			sb.AppendLine("Optimized " + Path.GetFileName(OriginalFileName) + " in " + Math.Round(Elapsed.TotalMilliseconds / 1000, 2) + " seconds");
			sb.AppendLine("Before: " + OriginalFileSize + " bytes");
			sb.AppendLine("After: " + ResultFileSize + " bytes");
			sb.AppendLine("Saving: " + Saving + " bytes / " + Percent + "%");

			return sb.ToString();
		}
	}

	public class ResponseFileInfo
	{
		public long Size { get; set; }
		public string Name { get; set; }

	}
}