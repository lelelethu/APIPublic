using System;
using System.ComponentModel;
using System.Linq;
using System.Reflection;

namespace TXAPI.Common
{
	public static class EnumExtensions
    {
        public static string ToDisplayName(this Enum enumValue)
        {
            if (enumValue == null)
                return string.Empty;

            var descriptionAttribute = enumValue.GetType()
                            .GetMember(enumValue.ToString())
                            .First()
                            .GetCustomAttribute<DescriptionAttribute>();

            if (descriptionAttribute != null)
            {
                return descriptionAttribute.Description;
            }
            else
            {
                return enumValue.ToString();
            }
        }
    }

	public enum JobStatus
	{
		[Description("Chờ xác nhận")]
		Wait = 1,
		[Description("Đã xác nhận")]
		Confirmed = 2,
		[Description("Hoàn thành")]
		Complete = 3,
		[Description("Hủy")]
		Cancel = 4,
		[Description("Từ chối")]
		Refuse = 6,
		[Description("Chờ xác nhận cho mượn")]
		LandWait = 15,
        [Description("Đang làm việc")]
        Working = 16,
    }

    public enum JobStatusType
    {
        [Description("BORROW")]
        Borrow = 1,
        [Description("LAND")]
        Land = 2,
    }
}
