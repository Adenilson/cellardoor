var dict = { }

function append(name, widget)
{
    dict[name] = widget
}

function retrieve(name)
{
    return dict[name]
}

function remove(name)
{
    dict[name] = null
}
