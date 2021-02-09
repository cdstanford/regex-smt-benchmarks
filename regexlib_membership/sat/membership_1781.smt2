;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ([0-1][0-9]|2[0-3]):[0-5][0-9]
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u0085\u00D9\u00A622:345"
(define-fun Witness1 () String (seq.++ "\x85" (seq.++ "\xd9" (seq.++ "\xa6" (seq.++ "2" (seq.++ "2" (seq.++ ":" (seq.++ "3" (seq.++ "4" (seq.++ "5" ""))))))))))
;witness2: "11:49"
(define-fun Witness2 () String (seq.++ "1" (seq.++ "1" (seq.++ ":" (seq.++ "4" (seq.++ "9" ""))))))

(assert (= regexA (re.++ (re.union (re.++ (re.range "0" "1") (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "3")))(re.++ (re.range ":" ":")(re.++ (re.range "0" "5") (re.range "0" "9"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
