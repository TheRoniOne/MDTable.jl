using DataFrames: DataFrame
using Tables, FileIO

"""
    writeMDTable(fileName::String, df)

Creates or overwrites a file named as fileName writing in it, under MD table format, the content of any type that implements the [Tables.jl](https://github.com/JuliaData/Tables.jl) interface.
"""
function writeMDTable(fileName::String, df)
    rows = Tables.rows(df)
    sch = Tables.schema(rows)
    names = Tables.columnnames(rows)
    header = true
    open(fileName, "w") do io
        headers::String = ""
        for i in 1:length(names)
            if i != length(names)
                headers = headers * "| $(names[i]) "
            else
                headers = headers * "| $(names[i]) " * "|\n"
            end
        end
        write(io, headers)
    end

    open(fileName, "a") do io
        write(io, "| --- " ^ length(names) * "|\n")
        for row in rows
            line::String = ""
            Tables.eachcolumn(sch, row) do val, i, nm
                line = line * "| $val "
            end
            write(io, line * "|\n")
        end
    end
end

"""
    save(f::File{format"MD"}, df)

Creates or overwrites a file named as fileName writing in it, under MD table format, the content of any type that implements the [Tables.jl](https://github.com/JuliaData/Tables.jl) interface.
"""
function save(f::File{format"MD"}, df)
    writeMDTable(f.filename, df)
end
