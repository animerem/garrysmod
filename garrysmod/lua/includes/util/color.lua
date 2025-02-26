
local COLOR = {}
COLOR.__index = COLOR

--[[---------------------------------------------------------
	Register our metatable to make it accessible using FindMetaTable
-----------------------------------------------------------]]
RegisterMetaTable( "Color", COLOR )

--[[---------------------------------------------------------
	To easily create a color table
-----------------------------------------------------------]]
function Color( r, g, b, a )

	a = a or 255
	return setmetatable( { r = math.min( tonumber(r), 255 ), g =  math.min( tonumber(g), 255 ), b =  math.min( tonumber(b), 255 ), a =  math.min( tonumber(a), 255 ) }, COLOR )

end

--[[---------------------------------------------------------
	Change the alpha of a color
-----------------------------------------------------------]]
function ColorAlpha( c, a )

	return Color( c.r, c.g, c.b, a )

end

--[[---------------------------------------------------------
	Checks if the given varible is a color object
-----------------------------------------------------------]]
function IsColor( obj )

	return getmetatable(obj) == COLOR

end


--[[---------------------------------------------------------
	Returns color as a string
-----------------------------------------------------------]]
function COLOR:__tostring()

	return string.format( "%d %d %d %d", self.r, self.g, self.b, self.a )

end

--[[---------------------------------------------------------
	Compares two colors
-----------------------------------------------------------]]
function COLOR:__eq( c )

	return self.r == c.r and self.g == c.g and self.b == c.b and self.a == c.a

end

--[[---------------------------------------------------------
	Converts a color to HSL color space
-----------------------------------------------------------]]
function COLOR:ToHSL()

	return ColorToHSL( self )

end

--[[---------------------------------------------------------
	Converts a color to HSV
-----------------------------------------------------------]]
function COLOR:ToHSV()

	return ColorToHSV( self )

end

--[[---------------------------------------------------------
	Converts color to vector - loss of precision / alpha lost
-----------------------------------------------------------]]
function COLOR:ToVector()

	return Vector( self.r / 255, self.g / 255, self.b / 255 )

end

--[[---------------------------------------------------------
	Unpacks the color into four variables
-----------------------------------------------------------]]
function COLOR:Unpack()

	return self.r, self.g, self.b, self.a

end

function COLOR:Lerp( target_clr, frac )

	return Color( Lerp( frac, self.r, target_clr.r ), Lerp( frac, self.g, target_clr.g ), Lerp( frac, self.b, target_clr.b ), Lerp( frac, self.a, target_clr.a ) )

end

function COLOR:SetUnpacked( r, g, b, a )

	if ( r != nil and !isnumber( r ) ) then error( "bad argument #1 to 'SetUnpacked' (number expected, got " .. type( r ) .. ")", 2 ) end
	if ( g != nil and !isnumber( g ) ) then error( "bad argument #2 to 'SetUnpacked' (number expected, got " .. type( g ) .. ")", 2 ) end
	if ( b != nil and !isnumber( b ) ) then error( "bad argument #3 to 'SetUnpacked' (number expected, got " .. type( b ) .. ")", 2 ) end
	if ( a != nil and !isnumber( a ) ) then error( "bad argument #4 to 'SetUnpacked' (number expected, got " .. type( a ) .. ")", 2 ) end

	self.r = r or 255
	self.g = g or 255
	self.b = b or 255
	self.a = a or 255

end

function COLOR:ToTable()

	return { self.r, self.g, self.b, self.a }

end

local imat = FindMetaTable( "IMaterial" )

-- This is so that the return value has the color meta table
function imat:GetColor( ... ) return Color( self:GetColor4Part( ... ) ) end
