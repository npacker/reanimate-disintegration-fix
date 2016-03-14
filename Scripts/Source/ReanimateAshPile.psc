Scriptname ReanimateAshPile extends ActiveMagicEffect
{Scripted effect for on death ash pile}

;-------------------------------------------------------------------------------
;
; PROPERTIES
;
;-------------------------------------------------------------------------------

FormList Property ImmunityList Auto
{If the target is in this list, they will not be disintegrated.}

Keyword Property ActorTypeDaedra Auto
{Keyword assigned to daedra actors.}

Keyword Property ActorTypeFamiliar Auto
{Keyword assigned to summoned familiar actors.}

Activator Property AshPileObject Auto
{The object we use as a pile.}

EffectShader Property MagicEffectShader Auto
{The Effect Shader we want.}

Float Property fDelay = 0.75 Auto
{time to wait before Spawning Ash Pile}

Float Property fDelayEnd = 1.65 Auto
{time to wait before Removing Base Actor}

Float Property ShaderDuration = 0.00 Auto
{Duration of Effect Shader.}

Bool Property bSetAlphaZero = True Auto
{Set victim alpha to zero.}

Bool Property bSetAlphaToZeroEarly = False Auto
{Use this If we want to set the acro to invisible somewhere before the effect shader is done.}

;-------------------------------------------------------------------------------
;
; VARIABLES
;
;-------------------------------------------------------------------------------

Bool AshPileCreated = False

Bool VictimIsImmune = False

Actor Victim

;-------------------------------------------------------------------------------
;
; FUNCTIONS
;
;-------------------------------------------------------------------------------

Bool Function IsImmune()

  Return IsSummoned() || ImmunityList.HasForm(Victim.GetRace())

EndFunction

Bool Function IsSummoned()

  Return Victim.IsCommandedActor() && (Victim.HasKeyword(ActorTypeFamiliar) || Victim.HasKeyword(ActorTypeDaedra))

EndFunction

Function TurnToAsh()

  Victim.SetCriticalStage(Victim.CritStage_DisintegrateStart)

  If Victim.Is3DLoaded()
    MagicEffectShader.Play(Victim, ShaderDuration)

    If bSetAlphaToZeroEarly
      Victim.SetAlpha(0.0, True)
    EndIf
  EndIf

  Utility.Wait(fDelay)
  Victim.AttachAshPile(AshPileObject)
  Utility.Wait(fDelayEnd)

  If Victim.Is3DLoaded()
    MagicEffectShader.Stop(Victim)

    If bSetAlphaZero
      Victim.SetAlpha(0.0, True)
    EndIf
  EndIf

  Victim.SetCriticalStage(Victim.CritStage_DisintegrateEnd)

EndFunction

;-------------------------------------------------------------------------------
;
; EVENTS
;
;-------------------------------------------------------------------------------

Event OnEffectStart(Actor Target, Actor Caster)

  Victim = Target
  VictimIsImmune = IsImmune()

EndEvent

Event OnEffectFinish(Actor Target, Actor Caster)

  Victim = None

EndEvent

Event OnDying(Actor Killer)

  If !VictimIsImmune && !AshPileCreated
    TurnToAsh()
    AshPileCreated = True
  EndIf

EndEvent
