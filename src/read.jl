using DataFrames: DataFrame
using FileIO

function readMDTable(file::String; header::Bool=true)::DataFrame
    mdTable::NamedTuple = NamedTuple()
    skip::Bool = header
    parsedHeader::Bool = false
    for line in eachline(file)
        if header
            mdTable = parseHeader(line)
            header = false
            parsedHeader = true
        elseif skip
            skip = false
        else
            if !parsedHeader
                mdTable = parseHeader(line, isHeader=false)
                parsedHeader = true
            end
            parseLine!(line, mdTable)
        end
    end
    return DataFrame(mdTable)
end

function parseHeader(line::String; isHeader::Bool=true)
    headersDirty = split(line, "|", keepempty=false)
    values::Array = []
    headersClean::Array = []
    count = 1
    for value in headersDirty
        key = lstrip(rstrip(value))
        if isHeader && key != ""
            push!(values, [])
            push!(headersClean, key)
        else
            push!(values, [])
            push!(headersClean, "x" * string(count))
            count += 1
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
