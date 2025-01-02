extends Node

var score: int = 0

var total: int = 0

var score_label: Label

var total_label: Label

func reset():
	score = 0
	total = 0

func increment_score():
	score += 1
	if score_label:
		score_label.text = str(score)

func increment_total():
	total += 1
	if total_label:
		total_label.text = str(total)
