﻿namespace TXAPI.Common
{
	public static class ResultCode
	{
		public const string OK = "OK";
		public const string ERROR = "ERROR";
		public const string ALREADY_EXISTS = "ALREADY_EXISTS";
		public const string INCORRECT = "INCORRECT";
	}

	public static class ResultMessage
	{
		public const string OK = "Success";
		public const string ERROR = "Some error occured, please try again";
		public const string ALREADY_EXISTS = "Already exists";
		public const string NOTSUPPORTED_FILETYPE = "Not Supported File Type";
		public const string FILESIZE_EXCEED = "Please Upload a file upto 1 mb.";
	}

	public class RestrictFileTypeMIME
	{
		public static readonly string[] acceptedFile = { ".doc", ".docx", ".xls", ".xlsx", ".pdf", ".jpeg", ".png" };
		public static readonly string[] acceptedImage = { ".jpeg", ".png", ".jpg", ".gif", ".bmp" };
	}
}