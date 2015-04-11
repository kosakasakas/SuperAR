using UnityEngine;
using System.Collections;
using UnitySampleAssets.Characters.ThirdPerson;

[RequireComponent(typeof (CustomThirdPersonCharacter))]
public class CustomThirdPersonUserControl : ThirdPersonUserControl {
	
	public GameObject beamTarget = null;
	public GameObject waveHandTarget = null;

	// Use this for initialization
	void Start () {
		base.Start ();
		character = GetComponent<CustomThirdPersonCharacter>();
	}
	
	// Update is called once per frame
	void Update () {

		// launch mega beam.
		if (!GetAnyDirectionKey() && Input.GetKey (KeyCode.Return)) {

			// update thirdParson direction
			if (beamTarget != null) {
				Transform targetTransform = beamTarget.transform;
				transform.rotation = Quaternion.Slerp (transform.rotation, Quaternion.LookRotation (targetTransform.position - transform.position), 0.07f);
			}

			// set up animation
			((CustomThirdPersonCharacter)character).MegaBeamStart ();

		} else {
			((CustomThirdPersonCharacter)character).MegaBeamStop ();
			base.Update ();
		}

		// launch wave hand.
		if (!GetAnyDirectionKey() && Input.GetKey (KeyCode.RightShift)) {

			// update thirdParson direction
			Vector3 cameraPos = waveHandTarget.transform.position;
			Vector3 targetPos = new Vector3(cameraPos.x, 0.0f, cameraPos.z);
			transform.rotation = Quaternion.Slerp (transform.rotation, Quaternion.LookRotation (targetPos - transform.position), 0.07f);

			// set up animation
			((CustomThirdPersonCharacter)character).WaveHandStart();

		} else {
			((CustomThirdPersonCharacter)character).WaveHandStop();
			base.Update ();
		}

	}
	
	bool GetAnyDirectionKey () {
		return (Input.GetKey (KeyCode.LeftArrow) || Input.GetKey (KeyCode.RightArrow) || Input.GetKey (KeyCode.UpArrow) || Input.GetKey (KeyCode.DownArrow));
	}
}
