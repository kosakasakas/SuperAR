using UnityEngine;
using System.Collections;
using UnitySampleAssets.Effects;

public class DamageEffectController : MonoBehaviour {

	public GameObject damageEffect1 = null;
	public GameObject damageEffect2 = null;
	public GameObject damageEffect3 = null;
	private Animator animator = null;
	private int damageId;
	private const float damageStepInterval = 3.0f; 
	private const int damageStepNum = 4;
	private float damageTime;
	private float[] initScales;
	private int factorNum = 3;

	// Use this for initialization
	void Start () {
		animator = GetComponent<Animator> ();
		damageId = Animator.StringToHash ("damaging");
		damageTime = damageStepNum * damageStepInterval;
	}
	
	// Update is called once per frame
	void Update () {
		bool isDamaging = animator.GetBool (damageId);
		if (isDamaging) {
			damageTime -= Time.deltaTime;
		} else {
			damageTime = damageStepNum * damageStepInterval;
		}
		UpdateEffect ();
	}

	void UpdateEffect() {
		int caseSwitch = (int) Mathf.Max((int)damageTime / (int)damageStepInterval, 0); 
		switch (caseSwitch) {
		case(0):
			print ("final stage");
			PlayDamageEffect(3);
			break;

		case(1):		
			print ("second stage");
			PlayDamageEffect(2);
			break;

		case(2):
		case(3):
			PlayDamageEffect(1);
			break;

		case(4):
			print ("safe stage");
			StopDamageEffect();
			break;

		default:
			print ("default");
			break;
		}
	}

	void PlayDamageEffect(int id) {
		switch(id) {
		case(1):
			if(damageEffect1) {
				damageEffect1.SetActive(true);
			}
			break;
		case(2):
			if(damageEffect2) {
				damageEffect2.SetActive(true);
			}
			break;
		case(3):
			if(damageEffect3) {
				damageEffect3.SetActive(true);
			}
			break;
		default:
			break;
		}
	}

	void StopDamageEffect() {
		if (damageEffect1) {
			damageEffect1.SetActive(false);
		}
		if (damageEffect2) {
			damageEffect2.SetActive(false);
		}
		if (damageEffect3) {
			damageEffect3.SetActive(false);
		}
	}
}