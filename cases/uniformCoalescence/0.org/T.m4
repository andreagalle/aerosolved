FoamFile
{
    version     2.0;
    format      ascii;
    class       volScalarField;
    location    "0";
    object      T;
}

dimensions      [0 0 0 1 0 0 0];

internalField   uniform VART;

boundaryField
{
    walls
    {
        type            zeroGradient;
    }
}
