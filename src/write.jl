using DataFrames: DataFrame
using Tables, FileIO

function writeMDTable(fileName::String, df)
    rows = Tables.rows(df)
    sch = Tables.schema(rows)
    names = Tables.columnnames(rows)
    for row in rows
        Tables.eachcolumn(sch, row) do val, i, nm
            println(val, i, nm)
        end
    end
end

function save(f::File{format"PNG"}, df)
    writeMDTable(f.filename, df)
end
