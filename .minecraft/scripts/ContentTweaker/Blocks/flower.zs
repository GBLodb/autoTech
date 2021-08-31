#priority 20
#modloaded atutils
#loader contenttweaker

import crafttweaker.world.IBlockPos;

import mods.contenttweaker.VanillaFactory;
import mods.randomtweaker.naturesaura.AuraChunk;
import mods.randomtweaker.cote.SubTileFunctional;
import mods.randomtweaker.cote.SubTileGenerating;


var auraFlower as SubTileFunctional = VanillaFactory.createSubTileFunctional("aura_flower", 0x4444FF);
auraFlower.range = 4;
auraFlower.onUpdate = function(subtile, world, pos) {
    var auraLowestPos = world.getLowestSpot(pos, 4, pos);
    var auraChunk as AuraChunk = world.getAuraChunk(auraLowestPos);

    if(!world.remote && subtile.getMana() > 0 && !isNull(auraChunk)) {
        subtile.addMana(-1);
        auraChunk.storeAura(auraLowestPos, 20);
    }
};
auraFlower.register();

var manaFlower as SubTileGenerating = VanillaFactory.createSubTileGenerating("mana_flower", 0x4444FF);
manaFlower.range = 4;
manaFlower.onUpdate = function(subtile, world, pos) {
    var auraHighestPos as IBlockPos = world.getHighestSpot(pos, 4, pos);
    var auraChunk as AuraChunk = world.getAuraChunk(auraHighestPos);

    if(!world.remote && !isNull(auraChunk) && 1000 != subtile.getMana()) {
        auraChunk.drainAura(auraHighestPos, 20);
        subtile.addMana(1);
    }
};
manaFlower.register();