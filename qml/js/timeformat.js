function getHours(value)
{
    return Math.floor(value / (3600));
}

function getMinutes(value)
{
    var divisor_for_minutes = value % (3600);
    return Math.floor(divisor_for_minutes / 60);
}

function formatDecimal(value)
{
    var result = value;
    if (value < 10)
	result = "0" + value
    return result
}

function toTime(hours, minutes)
{
    var obj = formatDecimal(hours) + ":" + formatDecimal(minutes)
    return obj;
}
