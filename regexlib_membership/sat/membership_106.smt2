;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (?<username>#?[_a-zA-Z0-9+-]+(\.[_a-zA-Z0-9+-]+)*)@(?<domain>[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*\.(([0-9]{1,3})|([a-zA-Z]{2,3})|(aero|coop|info|museum|name)))
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\x8\u00E2G-I.+@X.name@"
(define-fun Witness1 () String (seq.++ "\x08" (seq.++ "\xe2" (seq.++ "G" (seq.++ "-" (seq.++ "I" (seq.++ "." (seq.++ "+" (seq.++ "@" (seq.++ "X" (seq.++ "." (seq.++ "n" (seq.++ "a" (seq.++ "m" (seq.++ "e" (seq.++ "@" ""))))))))))))))))
;witness2: "+X.-+@l.aero>\u00BA"
(define-fun Witness2 () String (seq.++ "+" (seq.++ "X" (seq.++ "." (seq.++ "-" (seq.++ "+" (seq.++ "@" (seq.++ "l" (seq.++ "." (seq.++ "a" (seq.++ "e" (seq.++ "r" (seq.++ "o" (seq.++ ">" (seq.++ "\xba" "")))))))))))))))

(assert (= regexA (re.++ (re.++ (re.opt (re.range "#" "#"))(re.++ (re.+ (re.union (re.range "+" "+")(re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))))) (re.* (re.++ (re.range "." ".") (re.+ (re.union (re.range "+" "+")(re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z")))))))))))(re.++ (re.range "@" "@") (re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))(re.++ (re.* (re.++ (re.range "." ".") (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))))(re.++ (re.range "." ".") (re.union ((_ re.loop 1 3) (re.range "0" "9"))(re.union ((_ re.loop 2 3) (re.union (re.range "A" "Z") (re.range "a" "z"))) (re.union (str.to_re (seq.++ "a" (seq.++ "e" (seq.++ "r" (seq.++ "o" "")))))(re.union (str.to_re (seq.++ "c" (seq.++ "o" (seq.++ "o" (seq.++ "p" "")))))(re.union (str.to_re (seq.++ "i" (seq.++ "n" (seq.++ "f" (seq.++ "o" "")))))(re.union (str.to_re (seq.++ "m" (seq.++ "u" (seq.++ "s" (seq.++ "e" (seq.++ "u" (seq.++ "m" ""))))))) (str.to_re (seq.++ "n" (seq.++ "a" (seq.++ "m" (seq.++ "e" ""))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
