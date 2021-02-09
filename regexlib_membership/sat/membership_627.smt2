;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = /Dr[.]?|Phd[.]?|MBA/i
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00C8\u00F9MBA/i"
(define-fun Witness1 () String (seq.++ "\xc8" (seq.++ "\xf9" (seq.++ "M" (seq.++ "B" (seq.++ "A" (seq.++ "/" (seq.++ "i" ""))))))))
;witness2: "\u00C4\u00C2\u00FFwPhd.\u00E3\u00E5"
(define-fun Witness2 () String (seq.++ "\xc4" (seq.++ "\xc2" (seq.++ "\xff" (seq.++ "w" (seq.++ "P" (seq.++ "h" (seq.++ "d" (seq.++ "." (seq.++ "\xe3" (seq.++ "\xe5" "")))))))))))

(assert (= regexA (re.union (re.++ (str.to_re (seq.++ "/" (seq.++ "D" (seq.++ "r" "")))) (re.opt (re.range "." ".")))(re.union (re.++ (str.to_re (seq.++ "P" (seq.++ "h" (seq.++ "d" "")))) (re.opt (re.range "." "."))) (str.to_re (seq.++ "M" (seq.++ "B" (seq.++ "A" (seq.++ "/" (seq.++ "i" ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
