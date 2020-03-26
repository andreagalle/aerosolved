/*--------------------------------*- C++ -*----------------------------------*\
| =========                 |                                                 |
| \\      /  F ield         | OpenFOAM: The Open Source CFD Toolbox           |
|  \\    /   O peration     | Version:  4.x                                   |
|   \\  /    A nd           | Web:      www.OpenFOAM.org                      |
|    \\/     M anipulation  |                                                 |
\*---------------------------------------------------------------------------*/
FoamFile
{
    version     2.0;
    format      ascii;
    class       dictionary;
    object      blockMeshDict;
}

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //


metres 1;

vertices
(
	(0.25 0 0) //0 bottom hollow cylinder
	(0 0.25 0) //1
	(-0.25 0 0) //2
	(0 -0.25 0) //3 
	
	(0 0 -0.1) //4 center point bottom inlet pipe
	(0 0 0) //5 center point top inlet pipe
	
	(0.01 0 -0.1) //6 bottom inlet pipe
	(0 0.01 -0.1) //7
	(-0.01 0 -0.1) //8
	(0 -0.01 -0.1) //9 
	
	(0.01 0 0) //10 bottom inner cylinder
	(0 0.01 0) //11
	(-0.01 0 0) //12
	(0 -0.01 0) //13 
	
	(0.25 0 1) //14 top hollow cylinder
	(0 0.25 1) //15
	(-0.25 0 1) //16
	(0 -0.25 1) //17 
	
	(0 0 1) //18 center point top inner cylinder
	
	(0.01 0 1) //19 top inner cylinder
	(0 0.01 1) //20
	(-0.01 0 1) //21
	(0 -0.01 1) //22 
	
	
);

blocks //(x_cells equal between all blocks, y_cells equal between inlet and inner cylinder, z_cells at will)
(
	hex (10 11 5 5 19 20 18 18) (25 1 100) simpleGrading (1 1 1) //inner cylinder 
	hex (11 12 5 5 20 21 18 18) (25 1 100) simpleGrading (1 1 1)
	hex (12 13 5 5 21 22 18 18) (25 1 100) simpleGrading (1 1 1)
	hex (13 10 5 5 22 19 18 18) (25 1 100) simpleGrading (1 1 1) 
	
	hex (6 7 4 4 10 11 5 5) (25 1 10) simpleGrading (1 1 1) //inlet pipe
	hex (7 8 4 4 11 12 5 5) (25 1 10) simpleGrading (1 1 1)
	hex (8 9 4 4 12 13 5 5) (25 1 10) simpleGrading (1 1 1)
	hex (9 6 4 4 13 10 5 5) (25 1 10) simpleGrading (1 1 1) 
	
	hex (0 1 11 10 14 15 20 19) (25 24 100) simpleGrading (1 1 1) //hollow cylinder
	hex (1 2 12 11 15 16 21 20) (25 24 100) simpleGrading (1 1 1)
	hex (2 3 13 12 16 17 22 21) (25 24 100) simpleGrading (1 1 1)
	hex (3 0 10 13 17 14 19 22) (25 24 100) simpleGrading (1 1 1) 
);

edges
(
	arc 0 1 (0.17677 0.17677 0) //(cx+r*cos45 cy+r*sin45 0) bottom holllow cylinder
	arc 1 2 (-0.17677 0.17677 0)
	arc 2 3 (-0.17677 -0.17677 0)
	arc 3 0 (0.17677 -0.17677 0)
	
	arc 6 7 (0.00707 0.00707 -0.1) // bottom inlet pipe
	arc 7 8 (-0.00707 0.00707 -0.1) 
	arc 8 9 (-0.00707 -0.00707 -0.1) 
	arc 9 6 (0.00707 -0.00707 -0.1) 
	
	arc 10 11 (0.00707 0.00707 0) // top inlet pipe
	arc 11 12 (-0.00707 0.00707 0) 
	arc 12 13 (-0.00707 -0.00707 0) 
	arc 13 10 (0.00707 -0.00707 0)
	
	arc 14 15 (0.17677 0.17677 1) // top hollow cylinder
	arc 15 16 (-0.17677 0.17677 1)
	arc 16 17 (-0.17677 -0.17677 1)
	arc 17 14 (0.17677 -0.17677 1)
	
	arc 19 20 (0.00707 0.00707 1) // top inner cylinder
	arc 20 21 (-0.00707 0.00707 1) 
	arc 21 22 (-0.00707 -0.00707 1) 
	arc 22 19 (0.00707 -0.00707 1)
);

boundary
(
	jet_walls 
	{
		type wall;
		faces
		(
			(0 1 11 10) //bottom hollow cylinder 
			(1 2 12 11)
			(2 3 13 12)
			(3 0 10 13)
		);
	
		faces
		(		
			(0 14 15 1) //hollow cylinder shell
			(1 15 16 2)
			(2 16 17 3)
			(3 17 14 0)
		);
	}
	
	pipe_walls 
	{
		type wall;
		faces
		(		
			(6 10 11 7) //inlet pipe shell 
			(7 11 12 8)
			(8 12 13 9)
			(9 13 10 6)
		);
	}


	inlet
	{
		type patch;
		faces
		(
			(7 4 4 6) //inlet pipe bottom
			(8 4 4 7)
			(9 4 4 8)
			(6 4 4 9)
		);
	}

	outlet
	{
		type patch;
		faces
		(
			(14 19 20 15) //outlet hollow cylinder 
			(15 20 21 16)
			(16 21 22 17)
			(17 22 19 14)
		);
		
		faces
		(
			(19 18 18 20) //outlet inner cylinder
			(20 18 18 21)
			(21 18 18 22)
			(22 18 18 19)
		);
	}	
	
	//inner_cylinder_shell  (((mergePatchPairs faces)))
	//{
	//	type patch;
	//	faces
	//	(	
	//		() 
	//		()
	//		()
	//		()
	//	);
	//}
	//
	//hollow_cylinder_internal_shell
	//{
	//	type patch;
	//	faces
	//	(	
	//		()
	//		()
	//		()
	//		()
	//	);
	//}
	//
	//inlet_pipe_top
	//{
	//	type patch;
	//	faces
	//	(
	//		()
	//		()
	//		()
	//		()
	//	);
	//}
	//
	//inner_cylinder_bottom
	//{
	//	type patch;
	//	faces
	//	(
	//		() 
	//		()
	//		()
	//		()
	//	);
	//}
);

//mergePatchPairs
//(
//
//);

// ************************************************************************* //
