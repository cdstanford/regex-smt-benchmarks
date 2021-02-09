;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = "[^"]+" 
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00B1\"\u00A7\" "
(define-fun Witness1 () String (seq.++ "\xb1" (seq.++ "\x22" (seq.++ "\xa7" (seq.++ "\x22" (seq.++ " " ""))))))
;witness2: "\x14I\"\u00A3\" "
(define-fun Witness2 () String (seq.++ "\x14" (seq.++ "I" (seq.++ "\x22" (seq.++ "\xa3" (seq.++ "\x22" (seq.++ " " "")))))))

(assert (= regexA (re.++ (re.range "\x22" "\x22")(re.++ (re.+ (re.union (re.range "\x00" "!") (re.range "#" "\xff"))) (str.to_re (seq.++ "\x22" (seq.++ " " "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
