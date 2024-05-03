using System;
using System.Collections.Generic;

namespace TXAPI.Common
{
	public static class GetFileTypes
	{
		public static byte GetFileType(string contentType)
		{
			if (!string.IsNullOrEmpty(contentType))
			{
				var dictionay = ContentType();
				var type = dictionay[contentType];
				if (type == -1) return 0;
				return Convert.ToByte(dictionay[contentType]);
			}
			return 0;
		}

		public static short GetFileTypeInt(string contentType)
		{
			if (!string.IsNullOrEmpty(contentType))
			{
				var dictionay = ContentType();
				if (dictionay[contentType] < 0) return -1;
				return Convert.ToInt16(dictionay[contentType]);
			}
			return 0;
		}

		public static int GetFileTypeExtension(string extension)
		{
			if (!string.IsNullOrEmpty(extension))
			{
				var fileExtension = FileExtension();
				return fileExtension[extension];
			}
			return 0;
		}

		private static Dictionary<string, int> ContentType()
		{
			return new Dictionary<string, int>
			{
				{ "application/msword", 1 },
				{ "text/plain", 1 },
				{ "application/vnd.openxmlformats-officedocument.wordprocessingml.document", 1 },
				{ "application/vnd.openxmlformats-officedocument.wordprocessingml.template", 1 },
				{ "application/vnd.ms-word.document.macroEnabled.12", 1 },
				{ "application/vnd.ms-word.template.macroEnabled.12", 1 },
				{ "application/vnd.ms-excel", 2 },
				{ "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", 2 },
				{ "application/vnd.openxmlformats-officedocument.spreadsheetml.template", 2 },
				{ "application/vnd.ms-excel.sheet.macroEnabled.12", 2 },
				{ "application/vnd.ms-excel.template.macroEnabled.12", 2 },
				{ "application/vnd.ms-excel.addin.macroEnabled.12", 2 },
				{ "application/vnd.ms-excel.sheet.binary.macroEnabled.12", 2 },
				{ "application/octet-stream", 2 },
				{ "text/csv", 3 },				
				{ "image/png", 4 },
				{ "image/jpeg", 4 },
				{ "image/jpg", 4 },
				{ "image/gif", 4 },
				{ "image/bmp", 4 },
				{ "image/tiff", 4 },
				{ "image/pbm", 4 },
				{ "image/tga", 4 },
				//{ "image/avif", 4 },
				{ "image/webp", 4 },
				{ "image/vnd.microsoft.icon", 4 },
				{ "image/svg+xml", 4 },
				{ "application/x-rar-compressed", 5 },
				{ "application/zip", 5 },
				{ "application/x-7z-compressed", 5 },
				{ "application/vnd.ms-powerpoint", 6 },
				{ "application/vnd.openxmlformats-officedocument.presentationml.presentation", 6 },
				{ "application/vnd.openxmlformats-officedocument.presentationml.template", 6 },
				{ "application/vnd.openxmlformats-officedocument.presentationml.slideshow", 6 },
				{ "application/vnd.ms-powerpoint.addin.macroEnabled.12", 6 },
				{ "application/vnd.ms-powerpoint.presentation.macroEnabled.12", 6 },
				{ "application/vnd.ms-powerpoint.template.macroEnabled.12", 6 },
				{ "application/vnd.ms-powerpoint.slideshow.macroEnabled.12", 6 },
				{ "application/pdf", 7},
				{ "application/json", 8},				
			};
		}
		public static Dictionary<string, int> FileExtension()
		{
			return new Dictionary<string, int>
			{
				{ ".doc", 1 },
				{ ".docx", 1 },
				{ ".xlsx" , 2 },
				{ ".xls" , 2 },
				{ ".pdf", 3 },
				{ ".png" , 4 },
				{ ".jpg" , 4 },
				{ ".jpeg" , 4 },
				{ ".gif", 4 },
				{ ".rar" , 5 },
				{ ".zip" , 5 },
				{ ".ppt" , 6 },
				{ ".pptx" , 6 },
				{ ".pps" , 6 },
				{ ".ppsx" , 6 },
			};
		}
	}
}