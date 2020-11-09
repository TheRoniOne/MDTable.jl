using DataFrames: DataFrame
using FileIO

function readMDTable(file::String; header::Bool=true)::DataFrame
    mdTable::NamedTuple = NamedTuple()
    skip::Bool = header
    for line in eachline(file)
        if header
            mdTable = parseHeader(line)
            header = false
        elseif skip
            skip = false
        else
            parseLine!(line, mdTable)
        end
    end
    return DataFrame(mdTable)
end

function parseHeader(line::String)
    headersDirty = split(line, "|", keepempty=false)
    values::Array = []
    headersClean::Array = []
    for value in headersDirty
        key = lstrip(rstrip(value))
        if key != ""
            push!(values, [])
            push!(headersClean, key)
        end
    end
    return NamedTuple{(Symbol.(headersClean)...,)}(values)
end

function parseLine!(line::String, mdTable::NamedTuple)
    values = split(line, "|", keepempty=false)
    if length(values) != length(mdTable)
        error("The number of values in a line must be the same as the number of headers of the file")
    end

    for i in 1:length(values)
        value = lstrip(rstrip(values[i]))
        push!(getindex(mdTable, i), value)
    end
end

function load(f::File{format"MD"}; header::Bool=true)
    return readMDTable(f.filename, header=header)
end
