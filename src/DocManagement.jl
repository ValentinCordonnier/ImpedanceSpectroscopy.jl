
#=
	saveData(data::Vector{Complex}, nb::Int)

This function is used to store the data in CSV file, to either keep it or to plot it later

=#
function saveData(data::Vector{Complex}, nb::Int)


	out = zeros(length(data),3)
	index = 1
	for i in data
		reals = real(i[1])
    	imags = imag(i[1])
		freq = i[2]
		out[index,:] = vcat(reals, imags, freq)
		index += 1
	end

    CSV.write("datasets\\MyData$nb.csv", Tables.table(out),delim=',',decimal='.', header=false)
end

#=
	createAndSave(circuit::BaseCircuit, fStart::Int64, fEnd::Int64, nbEva::Int, nb::Int)

This function is used to combine the creation and the saving of new data in a CSV file

=#
function createAndSave(circuit::BaseCircuit, fStart::Int64, fEnd::Int64, nbEva::Int, nb)
	data = RangeFreq(circuit, fStart, fEnd, nbEva)

	saveData(data,nb)
end
