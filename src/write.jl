using DataFrames: DataFrame
using Tables, FileIO

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

function save(f::File{format"PNG"}, df)
    writeMDTable(f.filename, df)
end
