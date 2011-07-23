function splitTitle (title, lenght, position) {
    var str = title.substr(0, lenght)
    var lastPos = title.lenght < lenght ? lenght : str.lastIndexOf(" ")
    var titleRet;
    if (position === "first")
        titleRet = title.substr(0, lastPos)
    else
        titleRet = title.substr(lastPos+1)

    return titleRet
}
