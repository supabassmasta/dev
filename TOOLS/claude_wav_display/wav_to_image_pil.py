#!/usr/bin/env python3
"""
Convert WAV files to waveform images (amplitude vs time) using PIL.
"""

import argparse
import wave
import struct
from pathlib import Path
from PIL import Image, ImageDraw, ImageFont
from reportlab.lib.pagesizes import letter, A4
from reportlab.lib.units import inch
from reportlab.platypus import SimpleDocTemplate, Paragraph, Spacer, Image as RLImage
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
from reportlab.lib.enums import TA_LEFT


def wav_to_image(wav_path, output_path=None, width=1200, height=400, bg_color=(255, 255, 255),
                 wave_color=(46, 134, 171), line_color=(200, 200, 200)):
    """
    Convert a WAV file to a waveform image using PIL.

    Args:
        wav_path: Path to the input WAV file
        output_path: Path for the output image (default: same name as WAV with .png extension)
        width: Image width in pixels
        height: Image height in pixels
        bg_color: Background color RGB tuple
        wave_color: Waveform color RGB tuple
        line_color: Grid line color RGB tuple
    """
    wav_path = Path(wav_path)

    if output_path is None:
        output_path = wav_path.with_suffix('.png')
    else:
        output_path = Path(output_path)

    # Read WAV file
    with wave.open(str(wav_path), 'r') as wav_file:
        # Get WAV file parameters
        n_channels = wav_file.getnchannels()
        sample_width = wav_file.getsampwidth()
        framerate = wav_file.getframerate()
        n_frames = wav_file.getnframes()

        # Read audio data
        audio_data = wav_file.readframes(n_frames)

    # Convert byte data to amplitude values
    if sample_width == 1:
        # 8-bit unsigned
        samples = [struct.unpack('B', audio_data[i:i+1])[0] for i in range(0, len(audio_data), sample_width)]
        samples = [(s - 128) / 128.0 for s in samples]
    elif sample_width == 2:
        # 16-bit signed
        samples = [struct.unpack('<h', audio_data[i:i+2])[0] for i in range(0, len(audio_data), sample_width)]
        samples = [s / 32768.0 for s in samples]
    elif sample_width == 4:
        # 32-bit signed
        samples = [struct.unpack('<i', audio_data[i:i+4])[0] for i in range(0, len(audio_data), sample_width)]
        samples = [s / 2147483648.0 for s in samples]
    else:
        raise ValueError(f"Unsupported sample width: {sample_width}")

    # Handle multi-channel audio (mix down to mono for visualization)
    if n_channels > 1:
        mono_samples = []
        for i in range(0, len(samples), n_channels):
            # Average all channels
            avg = sum(samples[i:i+n_channels]) / n_channels
            mono_samples.append(avg)
        samples = mono_samples

    # Downsample if we have more samples than pixels
    if len(samples) > width:
        # Take max absolute value in each window for better visualization
        step = len(samples) / width
        downsampled = []
        for i in range(width):
            start = int(i * step)
            end = int((i + 1) * step)
            window = samples[start:end]
            if window:
                # Use max absolute value to show peaks
                max_val = max(abs(min(window)), abs(max(window)))
                downsampled.append(max_val if max(window) >= abs(min(window)) else -max_val)
        samples = downsampled

    # Create image
    img = Image.new('RGB', (width, height), bg_color)
    draw = ImageDraw.Draw(img)

    # Draw grid lines
    mid_y = height // 2
    draw.line([(0, mid_y), (width, mid_y)], fill=line_color, width=1)

    # Draw waveform
    for x in range(len(samples)):
        # Convert amplitude (-1.0 to 1.0) to y coordinate
        amplitude = max(-1.0, min(1.0, samples[x]))  # Clamp
        y = int(mid_y - (amplitude * (height // 2 - 10)))

        # Draw line from center to amplitude
        draw.line([(x, mid_y), (x, y)], fill=wave_color, width=1)

    # Add text label
    try:
        font = ImageFont.truetype("/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf", 12)
    except:
        font = ImageFont.load_default()

    duration = n_frames / framerate
    label = f"{wav_path.name} | {n_channels}ch | {framerate}Hz | {duration:.3f}s"
    draw.text((10, 10), label, fill=(0, 0, 0), font=font)

    # Save image
    img.save(output_path)

    print(f"Created: {output_path}")
    print(f"  Channels: {n_channels}, Sample Rate: {framerate} Hz, Duration: {duration:.3f}s")


def main():
    parser = argparse.ArgumentParser(
        description='Convert WAV files to waveform images (amplitude vs time)'
    )
    parser.add_argument(
        'input',
        nargs='*',
        help='Input WAV file(s) or directories. If not specified, processes all .wav files in current directory and subdirectories'
    )
    parser.add_argument(
        '-o', '--output',
        help='Output image path (only valid for single input file)'
    )
    parser.add_argument(
        '--output-dir',
        default='waveforms',
        help='Output directory for generated images (default: waveforms)'
    )
    parser.add_argument(
        '--width',
        type=int,
        default=1200,
        help='Image width in pixels (default: 1200)'
    )
    parser.add_argument(
        '--height',
        type=int,
        default=400,
        help='Image height in pixels (default: 400)'
    )
    parser.add_argument(
        '--pdf',
        default='waveforms.pdf',
        help='Generate PDF file with all images (default: waveforms.pdf)'
    )

    args = parser.parse_args()

    # Determine input files
    if args.input:
        wav_files = []
        for input_path in args.input:
            path = Path(input_path)
            if path.is_file():
                wav_files.append(path)
            elif path.is_dir():
                # Recursively find WAV files in directory
                wav_files.extend(sorted(path.rglob('*.wav')))
            else:
                print(f"Warning: {input_path} is not a valid file or directory")
    else:
        # Process all WAV files in current directory and subdirectories
        wav_files = sorted(Path('.').rglob('*.wav'))
        if not wav_files:
            print("No WAV files found in current directory or subdirectories")
            return

    # Validate input files
    for wav_file in wav_files:
        if not wav_file.exists():
            print(f"Error: File not found: {wav_file}")
            return
        if not wav_file.suffix.lower() == '.wav':
            print(f"Error: Not a WAV file: {wav_file}")
            return

    # Check output argument conflicts
    if args.output and len(wav_files) > 1:
        print("Error: --output can only be used with a single input file")
        return

    # Create output directory if using it
    if not args.output and len(wav_files) > 0:
        output_dir = Path(args.output_dir)
        output_dir.mkdir(exist_ok=True)
        print(f"Saving images to: {output_dir.absolute()}\n")

    # Process files and track output paths
    wav_image_pairs = []
    for wav_file in wav_files:
        if args.output and len(wav_files) == 1:
            output = args.output
        else:
            # Save to output directory with same filename
            output_dir = Path(args.output_dir)
            output = output_dir / wav_file.with_suffix('.png').name

        try:
            wav_to_image(wav_file, output, width=args.width, height=args.height)
            wav_image_pairs.append((wav_file, output))
        except Exception as e:
            print(f"Error processing {wav_file}: {e}")
            import traceback
            traceback.print_exc()

    # Generate PDF file
    if wav_image_pairs and args.pdf:
        pdf_path = Path(args.pdf)
        doc = SimpleDocTemplate(str(pdf_path), pagesize=A4)
        story = []
        styles = getSampleStyleSheet()

        # Title
        title_style = ParagraphStyle(
            'CustomTitle',
            parent=styles['Heading1'],
            fontSize=24,
            spaceAfter=30,
        )
        story.append(Paragraph("WAV Waveform Images", title_style))
        story.append(Spacer(1, 0.2*inch))

        # Path style
        path_style = ParagraphStyle(
            'PathStyle',
            parent=styles['Normal'],
            fontSize=10,
            textColor='blue',
            spaceAfter=6,
        )

        # Add each WAV path and corresponding image
        for wav_path, img_path in wav_image_pairs:
            # Add WAV file path
            story.append(Paragraph(str(wav_path), path_style))

            # Add waveform image
            # Scale image to fit page width (with margins)
            img_width = 6.5 * inch
            img_height = (img_width / 1200) * 400  # Maintain aspect ratio
            story.append(RLImage(str(img_path), width=img_width, height=img_height))
            story.append(Spacer(1, 0.3*inch))

        # Build PDF
        doc.build(story)
        print(f"\nPDF file created: {pdf_path}")


if __name__ == '__main__':
    main()
