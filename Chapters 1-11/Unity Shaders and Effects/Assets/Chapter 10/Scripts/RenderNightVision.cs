using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class RenderNightVision : MonoBehaviour {

    #region Variables 
    public Shader curShader;

    public float contrast = 3.0f;
    public float brightness = 0.1f;
    public Color nightVisionColor = Color.green;

    public Texture2D vignetteTexture;

    public Texture2D scanLineTexture;
    public float scanLineTileAmount = 4.0f;

    public Texture2D nightVisionNoise;
    public float noiseXSpeed = 100.0f;
    public float noiseYSpeed = 100.0f;

    public float distortion = 0.2f;
    public float scale = 0.8f;

    private float randomValue = 0.0f;
    private Material screenMat;
    #endregion

    #region Properties
    Material ScreenMat
    {
        get
        {
            if (screenMat == null)
            {
                screenMat = new Material(curShader);
                screenMat.hideFlags = HideFlags.HideAndDontSave;
            }
            return screenMat;
        }
    }
    #endregion

    void Start()
    {
        if (!SystemInfo.supportsImageEffects)
        {
            enabled = false;
            return;
        }

        if (!curShader && !curShader.isSupported)
        {
            enabled = false;
        }
    }

    void OnRenderImage(RenderTexture sourceTexture, RenderTexture destTexture)
    {
        if (curShader != null)
        {
            ScreenMat.SetFloat("_Contrast", contrast);
            ScreenMat.SetFloat("_Brightness", brightness);
            ScreenMat.SetColor("_NightVisionColor", nightVisionColor);
            ScreenMat.SetFloat("_RandomValue", randomValue);
            ScreenMat.SetFloat("_distortion", distortion);
            ScreenMat.SetFloat("_scale", scale);

            if (vignetteTexture)
            {
                ScreenMat.SetTexture("_VignetteTex", vignetteTexture);
            }

            if (scanLineTexture)
            {
                ScreenMat.SetTexture("_ScanLineTex", scanLineTexture);
                ScreenMat.SetFloat("_ScanLineTileAmount", scanLineTileAmount);
            }

            if (nightVisionNoise)
            {
                ScreenMat.SetTexture("_NoiseTex", nightVisionNoise);
                ScreenMat.SetFloat("_NoiseXSpeed", noiseXSpeed);
                ScreenMat.SetFloat("_NoiseYSpeed", noiseYSpeed);
            }

            Graphics.Blit(sourceTexture, destTexture, ScreenMat);
        }
        else
        {
            Graphics.Blit(sourceTexture, destTexture);
        }
    }

    // Update is called once per frame
    void Update()
    {
        contrast = Mathf.Clamp(contrast, 0f, 4f);
        brightness = Mathf.Clamp(brightness, 0f, 2f);
        randomValue = Random.Range(-1f, 1f);
        distortion = Mathf.Clamp(distortion, -1f, 1f);
        scale = Mathf.Clamp(scale, 0f, 3f);
    }

    void OnDisable()
    {
        if (screenMat)
        {
            DestroyImmediate(screenMat);
        }
    }
}
