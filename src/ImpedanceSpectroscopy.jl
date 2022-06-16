module ImpedanceSpectroscopy


    using CSV
    using DataFrames
    using Plots


    export s,p
    export AbstractElem, L, R, C, CPE
    export calcImp, calcOmega

    export AbstractCircuit, getImp, getFreq, getElem
    export calculateCircuitLength, ImpedanceCircuit
    export modZ, argZ
    export RangeFreq

    export saveData, createAndSave

    export plotNyquist, plotBode


    include("Elements.jl")
    include("Circuits.jl")
    include("DocManagement.jl")
    include("PlotSpectro.jl")


end #module
