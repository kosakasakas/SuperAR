using UnityEngine;
using System.Collections;
using UnitySampleAssets.Characters.ThirdPerson;

public class CustomThirdPersonCharacter : ThirdPersonCharacter {

	private bool beam;
	private bool waveHand; 
	public ParticleSystem beamParticle = null;

	// Use this for initialization
	void Start () {
		base.Start ();
	}

	public void MegaBeamStart() {
		beam = true;
	}

	public void MegaBeamStop() {
		beam = false;
	}

	public void WaveHandStart() {
		waveHand = true;
	}

	public void WaveHandStop() {
		waveHand = false;
	}

	protected override void UpdateAnimator()
	{
		animator.SetBool("Beam", beam);
		animator.SetBool("WaveHand", waveHand);

		base.UpdateAnimator ();

		UpdateBeamEffect ();

		Debug.Log (beam);
	}
	
	private void UpdateBeamEffect() {
		if (!beamParticle) {
			return;
		}

		if (beam) {
			beamParticle.Play();
		} else {
			beamParticle.Stop();
		}
	}
}
