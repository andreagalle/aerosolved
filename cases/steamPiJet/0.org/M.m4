FoamFile
{
    version     2.0;
    format      ascii;
    class       volScalarField;
    location    "0";
    object      M;
}

dimensions      [-1 0 0 0 0 0 0];

internalField   uniform 0.0;

boundaryField
{
    inlet
    {
        type        VARMINLETBCNAME;
        CMD         1E-6;
        sigma       4.0;
        value       $internalField;
    }

    outlet
    {
        type        inletOutlet;
        inletValue  $internalField;
        value       $internalField;
    }

    jet_walls
    {
        type        zeroGradient;
    }

    pipe_walls
    {
        type        zeroGradientAbsorbingWall;
        value       $internalField;
    }
}
