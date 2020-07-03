gc .\a.json | % {
    if ($_ -match "//-+ *(?<name>\w+) *-+//") {
        $name = $matches["name"]
        # $name.length
        "    //{0:s}  {1:s}  {2:+s}//" -f ("-" * 30), $name, ("-" * (38 - $name.length))
    }
    else {
        $_
    }
}