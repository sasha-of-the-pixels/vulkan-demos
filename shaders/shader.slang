static const int N_WAVES = 4;
static const float g = 9.8; // gravitational constant
static const float pi = 3.1415926535897932384; // tau/2 or something. heard it's a kinda important number for some things?

static const float medianAmp = 1. / N_WAVES;

static const float3 topColor = { .7843, .9804, .8392 };
static const float3 bottomColor = { .3137, .2667, .5529 };

struct VSInput {
    float2 inPosition;
    float3 inColor;
};

struct UniformBuffer {
    float4x4 model;
    float4x4 view;
    float4x4 proj;
    float4x2 centers;
    float4 wavelengths;
    float time;
}
ConstantBuffer<UniformBuffer> ubo;

struct VSOutput {
    float4 pos : SV_Position;
    float waveHeight;
};



[shader("vertex")]
VSOutput vertMain(VSInput input) {
    // initialize output
    float2 uv = input.inPosition.xy;
    VSOutput output = {
        float4(uv, 0., 1.),
        0.
    };

    // determine sine parameters
    float4x2 D;
    float4 speeds;
    for (int i = 0; i < N_WAVES; i++) {
        float4 rowExtractor = float4(0.);
        rowExtractor[i] = 1.;

        float2 c = mul(rowExtractor, ubo.centers);
        D[i] = normalize(uv-c);
        speeds[i] = sqrt(g * 2. * pi / ubo.wavelengths[i]);
        float freq = 2. / ubo.wavelengths[i];
        float phi = speeds[i] * freq;

        float amp = 

        output.pos.z += 0.1 * sin(dot(D[i], uv) * freq + phi * ubo.time);
    }

    output.waveHeight = output.pos.z;

    // apply model view proj matrices
    output.pos = mul(
        ubo.proj, 
        mul(
            ubo.view, 
            mul(ubo.model, output.pos)
        )
    );
    return output;
}

[shader("fragment")]
float4 fragMain(VSOutput vertIn) : SV_Target
{
    return float4(float3(lerp(bottomColor, topColor, float3(vertIn.waveHeight))), 1.0);
}