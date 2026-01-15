{ pkgs, ... }:

{
	home.packages = with pkgs; [
		showmethekey
	];
}
