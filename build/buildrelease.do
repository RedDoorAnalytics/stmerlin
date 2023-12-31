//build new version of stmerlin
//
// --> run whole do file


local drive /Users/Michael/My Drive/products
cd "`drive'/stmerlin/"

//============================================================================//

//build new release -> current version up is 1.0.0
local newversion 1_0_0

cap mkdir ./release/version_`newversion'
local fdir "`drive'/stmerlin/release/version_`newversion'/"

//============================================================================//

//pkg files
copy ./build/stmerlin_details.txt `"`fdir'"', replace
	
//============================================================================//

//stmerlin

	copy ./stmerlin/stmerlin.ado `"`fdir'"', replace

	//help files
	copy ./stmerlin/stmerlin.sthlp `"`fdir'"', replace
	copy ./stmerlin/stmerlin_postestimation.sthlp `"`fdir'"', replace
