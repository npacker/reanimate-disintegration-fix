Scriptname RDF_ApplyZombieEffectsEffectScript extends ActiveMagicEffect
{Apply zombie effects to zombie while tracked.}

FormList Property RDF_ZombieEffectsList Auto
{Form list of effects to apply.}

Event OnEffectStart(Actor Caster, Actor Target)

  Debug.TraceAndBox("Applying Zombie Effects to " + Target)

  Int i = RDF_ZombieEffectsList.GetSize()

  While i
    i -= 1
    Spell ZombieEffect = RDF_ZombieEffectsList.GetAt(i) as Spell

    Target.AddSpell(ZombieEffect)

    Debug.TraceAndBox("Applied Zombie Effect " + ZombieEffect)
  EndWhile

EndEvent

Event OnEffectFinish(Actor Caster, Actor Target)

  Debug.TraceAndBox("Removing Zombie Effects from " + Target)

  Int i = RDF_ZombieEffectsList.GetSize()

  While i
    i -= 1
    Spell ZombieEffect = RDF_ZombieEffectsList.GetAt(i) as Spell

    Target.AddSpell(ZombieEffect)

    Debug.TraceAndBox("Removed Zombie Effect " + ZombieEffect)
  EndWhile

EndEvent
