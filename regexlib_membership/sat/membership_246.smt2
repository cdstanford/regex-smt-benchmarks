;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \d{1,2}d \d{1,2}h
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "80d 81hd\u0084"
(define-fun Witness1 () String (seq.++ "8" (seq.++ "0" (seq.++ "d" (seq.++ " " (seq.++ "8" (seq.++ "1" (seq.++ "h" (seq.++ "d" (seq.++ "\x84" ""))))))))))
;witness2: "89d 2h\u0099"
(define-fun Witness2 () String (seq.++ "8" (seq.++ "9" (seq.++ "d" (seq.++ " " (seq.++ "2" (seq.++ "h" (seq.++ "\x99" ""))))))))

(assert (= regexA (re.++ ((_ re.loop 1 2) (re.range "0" "9"))(re.++ (str.to_re (seq.++ "d" (seq.++ " " "")))(re.++ ((_ re.loop 1 2) (re.range "0" "9")) (re.range "h" "h"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
