;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [0][x][0-9a-fA-F]+
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "0xCc\u00D1x"
(define-fun Witness1 () String (seq.++ "0" (seq.++ "x" (seq.++ "C" (seq.++ "c" (seq.++ "\xd1" (seq.++ "x" "")))))))
;witness2: "\xC]\u009B\u00E6\x190x09cA"
(define-fun Witness2 () String (seq.++ "\x0c" (seq.++ "]" (seq.++ "\x9b" (seq.++ "\xe6" (seq.++ "\x19" (seq.++ "0" (seq.++ "x" (seq.++ "0" (seq.++ "9" (seq.++ "c" (seq.++ "A" ""))))))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "0" (seq.++ "x" ""))) (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
