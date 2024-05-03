namespace TXAPI.Common
{
	public class UploadFolder
	{
		public const string Image = "UploadFiles/Image/";
		public const string Log = "UploadFiles/Log/";
		public const string Json = "UploadFiles/Json/";
		public const string Excel = "UploadFiles/Excel/";
	}
	public class MessageInfo
	{
		public const string File_UploadImage_NotSupport = "The system does not support converting to {0}!";
		public const string File_UploadImage_FileNotFound = "File not found!";
		public const string File_UploadImage_FormatSame = "Source and destination formats are the same, choose another format to convert!";
		public const string Token_BearTokenToJson_TokenEmpty = "Token is empty!";
		public const string Token_BearTokenToJson_Invalid = "Invalid token string!";
		public const string Text_CompareText_InputEmpty = "Input is empty!";
		public const string Text_ConvertTextFormat_InputEmpty = "Input is empty!";
		public const string Text_ConvertTextFormat_InputWrong = "Format input is wrong!";
		public const string Text_ConvertTextFormat_NotBinary = "Input is not Binary!";
		public const string Text_ConvertTextFormat_NotHex = "Input is not Hex!";
		public const string Text_ConvertTextToBase64_InputEmpty = "Input is empty!";
		public const string Hash_GeneratorHash_InputEmpty = "Input is empty!";
		public const string Hash_GeneratorHash_HavalIncorrect = "Haval input is incorrect!";
		public const string Youtube_ConvertLink_InputEmpty = "Input is empty!";
		public const string Youtube_ConvertLink_NoURL = "URL not found!";
		public const string Excel_ExcelToJson_NotExcelCsv = "File is not Excel or Csv!";
		public const string Excel_ExcelToJson_FileEmpty = "File is empty!";
		public const string Excel_ExcelToJson_Error = "An error occurred!";
		public const string Json_ConvertToExcelFile_NotJson = "File is not Json!";
		public const string Json_ConvertToExcel_WrongFormat = "Json format is wrong!";
		public const string Json_ConvertToExcelText_InputEmpty = "Input is empty!";
		public const string Time_ConvertTimestampToDate_InvalidInput = "Invalid timestamp!";
		public const string Url_InputEmpty = "Input is empty!";
		public const string Url_IncorrectUrlFormat = "Incorrect url format!";
		public const string SEO_IncorrectUrlFormat = "Url Token is empty!";
		public const string SEO_CrawlingOccurredError = "An error occurred while crawling the data!";


	}
	public class ShortLinkConst
	{
		public const string BasedLink = "https://s.thutool.com/";
	}
}