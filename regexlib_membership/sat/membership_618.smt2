;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (\[a url=\"[^\[\]\"]*\"\])([^\[\]]+)(\[/a\])
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "[a url=\"\u00D0\u00B8\u00A0\u00C1\"]\u00BD[/a]"
(define-fun Witness1 () String (seq.++ "[" (seq.++ "a" (seq.++ " " (seq.++ "u" (seq.++ "r" (seq.++ "l" (seq.++ "=" (seq.++ "\x22" (seq.++ "\xd0" (seq.++ "\xb8" (seq.++ "\xa0" (seq.++ "\xc1" (seq.++ "\x22" (seq.++ "]" (seq.++ "\xbd" (seq.++ "[" (seq.++ "/" (seq.++ "a" (seq.++ "]" ""))))))))))))))))))))
;witness2: "P\u00E5\u00D4[a url=\"\"]0[/a]}\u00D2"
(define-fun Witness2 () String (seq.++ "P" (seq.++ "\xe5" (seq.++ "\xd4" (seq.++ "[" (seq.++ "a" (seq.++ " " (seq.++ "u" (seq.++ "r" (seq.++ "l" (seq.++ "=" (seq.++ "\x22" (seq.++ "\x22" (seq.++ "]" (seq.++ "0" (seq.++ "[" (seq.++ "/" (seq.++ "a" (seq.++ "]" (seq.++ "}" (seq.++ "\xd2" "")))))))))))))))))))))

(assert (= regexA (re.++ (re.++ (str.to_re (seq.++ "[" (seq.++ "a" (seq.++ " " (seq.++ "u" (seq.++ "r" (seq.++ "l" (seq.++ "=" (seq.++ "\x22" "")))))))))(re.++ (re.* (re.union (re.range "\x00" "!")(re.union (re.range "#" "Z")(re.union (re.range "\x5c" "\x5c") (re.range "^" "\xff"))))) (str.to_re (seq.++ "\x22" (seq.++ "]" "")))))(re.++ (re.+ (re.union (re.range "\x00" "Z")(re.union (re.range "\x5c" "\x5c") (re.range "^" "\xff")))) (str.to_re (seq.++ "[" (seq.++ "/" (seq.++ "a" (seq.++ "]" "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
