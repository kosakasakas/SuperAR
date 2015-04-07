using UnityEngine;
using System.Collections;
using UnitySampleAssets.Characters.ThirdPerson;

[RequireComponent(typeof (CustomThirdPersonCharacter))]
public class CustomThirdPersonUserControl : ThirdPersonUserControl {

	// Use this for initialization
	void Start () {
		base.Start ();
		character = GetComponent<CustomThirdPersonCharacter>();
	}
	
	// Update is called once per frame
	void Update () {
		base.Update ();
		// launch mega beam.
		if (!GetAnyDirectionKey() && Input.GetKey (KeyCode.Return)) {
			((CustomThirdPersonCharacter)character).MegaBeamStart ();
		} else {
			((CustomThirdPersonCharacter)character).MegaBeamStop ();
		}

		// launch wave hand.
		if (!GetAnyDirectionKey() && Input.GetKey (KeyCode.RightShift)) {
			((CustomThirdPersonCharacter)character).WaveHandStart();
		} else {
			((CustomThirdPersonCharacter)character).WaveHandStop();
		}

	}

	bool GetAnyDirectionKey () {
		return (Input.GetKey (KeyCode.LeftArrow) || Input.GetKey (KeyCode.RightArrow) || Input.GetKey (KeyCode.UpArrow) || Input.GetKey (KeyCode.DownArrow));
	}
}
