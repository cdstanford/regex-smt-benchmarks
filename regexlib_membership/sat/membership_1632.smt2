;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [0-9A-Fa-f]{2}(\.?)[0-9A-Fa-f]{2}(\.?)[0-9A-Fa-f]{2}(\.?)[0-9A-Fa-f]{2}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00FE(e\u0088\u00F2f3.F0F9.F9"
(define-fun Witness1 () String (seq.++ "\xfe" (seq.++ "(" (seq.++ "e" (seq.++ "\x88" (seq.++ "\xf2" (seq.++ "f" (seq.++ "3" (seq.++ "." (seq.++ "F" (seq.++ "0" (seq.++ "F" (seq.++ "9" (seq.++ "." (seq.++ "F" (seq.++ "9" ""))))))))))))))))
;witness2: "19.FFd8a9"
(define-fun Witness2 () String (seq.++ "1" (seq.++ "9" (seq.++ "." (seq.++ "F" (seq.++ "F" (seq.++ "d" (seq.++ "8" (seq.++ "a" (seq.++ "9" ""))))))))))

(assert (= regexA (re.++ ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))(re.++ (re.opt (re.range "." "."))(re.++ ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))(re.++ (re.opt (re.range "." "."))(re.++ ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))(re.++ (re.opt (re.range "." ".")) ((_ re.loop 2 2) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
