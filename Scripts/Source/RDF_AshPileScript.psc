Scriptname RDF_AshPileScript extends ActiveMagicEffect
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

Float fShaderDuration = 4.0

Actor Victim = None

;-------------------------------------------------------------------------------
;
; FUNCTIONS
;
;-------------------------------------------------------------------------------

Function TurnToAsh()

  GoToState("Busy")

  If !Victim.IsDead()
    GoToState("Ready")

    Return
  EndIf

  Victim.SetCriticalStage(Victim.CritStage_DisintegrateStart)

  If Victim.Is3DLoaded()
    ShockDisintegrate01FXS.Play(Victim, fShaderDuration)
  EndIf

  Utility.Wait(fDelay)
  Victim.AttachAshPile()
  Utility.Wait(fDelayEnd)

  If Victim.Is3DLoaded()
    ShockDisintegrate01FXS.Stop(Victim)
    Victim.SetAlpha(0.0, True)
  EndIf

  Victim.SetCriticalStage(Victim.CritStage_DisintegrateEnd)
  Debug.TraceAndBox("Zombie Turned to Ash: " + Victim)

EndFunction

;-------------------------------------------------------------------------------
;
; EVENTS
;
;-------------------------------------------------------------------------------

Auto State Ready

  Event OnEffectStart(Actor Target, Actor Caster)

    Victim = Target

    Debug.TraceAndBox("Applied Ash Pile Effect: " + Target)

  EndEvent

  Event OnDying(Actor Killer)

    TurnToAsh()

  EndEvent

  Event OnDeath(Actor Killer)

    TurnToAsh()

  EndEvent

EndState

State Busy

  Event OnDying(Actor Killer)
  EndEvent

  Event OnDeath(Actor Killer)
  EndEvent

EndState
