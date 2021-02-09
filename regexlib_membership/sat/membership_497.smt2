;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ICON=[a-zA-Z0-9/\+-;:/-/\"=]*
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "ICON=\u0097"
(define-fun Witness1 () String (seq.++ "I" (seq.++ "C" (seq.++ "O" (seq.++ "N" (seq.++ "=" (seq.++ "\x97" "")))))))
;witness2: "gICON=\u00F3"
(define-fun Witness2 () String (seq.++ "g" (seq.++ "I" (seq.++ "C" (seq.++ "O" (seq.++ "N" (seq.++ "=" (seq.++ "\xf3" ""))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "I" (seq.++ "C" (seq.++ "O" (seq.++ "N" (seq.++ "=" "")))))) (re.* (re.union (re.range "\x22" "\x22")(re.union (re.range "+" ";")(re.union (re.range "=" "=")(re.union (re.range "A" "Z") (re.range "a" "z")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
