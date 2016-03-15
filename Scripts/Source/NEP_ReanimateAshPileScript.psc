Scriptname NEP_ReanimateAshPileScript extends ActiveMagicEffect
{Scripted effect for on death ash pile}

;-------------------------------------------------------------------------------
;
; PROPERTIES
;
;-------------------------------------------------------------------------------

EffectShader Property ShockDisintegrate01FXS Auto
{The Effect Shader we want.}

;-------------------------------------------------------------------------------
;
; VARIABLES
;
;-------------------------------------------------------------------------------

Float fDelay = 1.25

Float fDelayEnd = 1.65

Float ShaderDuration = 4.00

Bool AshPileCreated = False

Activator AshPileObject

Actor Victim

;-------------------------------------------------------------------------------
;
; FUNCTIONS
;
;-------------------------------------------------------------------------------

Function TurnToAsh()

  Victim.SetCriticalStage(Victim.CritStage_DisintegrateStart)

  If Victim.Is3DLoaded()
    ShockDisintegrate01FXS.Play(Victim, ShaderDuration)
  EndIf

  Utility.Wait(fDelay)
  Victim.AttachAshPile(AshPileObject)
  Utility.Wait(fDelayEnd)

  If Victim.Is3DLoaded()
    ShockDisintegrate01FXS.Stop(Victim)
    Victim.SetAlpha(0.0, True)
  EndIf

  Victim.SetCriticalStage(Victim.CritStage_DisintegrateEnd)

EndFunction

;-------------------------------------------------------------------------------
;
; EVENTS
;
;-------------------------------------------------------------------------------

Event OnEffectStart(Actor Target, Actor Caster)

  Debug.Trace("NEP_ReanimateAshPile: OnEffectStart")

  Victim = Target

EndEvent

Event OnDying(Actor Killer)

  Debug.Trace("NEP_ReanimateAshPile: OnDying")

  If !AshPileCreated
    TurnToAsh()
    AshPileCreated = True
    Debug.Trace("NEP_ReanimateAshPile: Ash pile created")
  EndIf

EndEvent
