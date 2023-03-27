;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (?<username>#?[_a-zA-Z0-9+-]+(\.[_a-zA-Z0-9+-]+)*)@(?<domain>[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*\.(([0-9]{1,3})|([a-zA-Z]{2,3})|(aero|coop|info|museum|name)))
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\x8\u00E2G-I.+@X.name@"
(define-fun Witness1 () String (str.++ "\u{08}" (str.++ "\u{e2}" (str.++ "G" (str.++ "-" (str.++ "I" (str.++ "." (str.++ "+" (str.++ "@" (str.++ "X" (str.++ "." (str.++ "n" (str.++ "a" (str.++ "m" (str.++ "e" (str.++ "@" ""))))))))))))))))
;witness2: "+X.-+@l.aero>\u00BA"
(define-fun Witness2 () String (str.++ "+" (str.++ "X" (str.++ "." (str.++ "-" (str.++ "+" (str.++ "@" (str.++ "l" (str.++ "." (str.++ "a" (str.++ "e" (str.++ "r" (str.++ "o" (str.++ ">" (str.++ "\u{ba}" "")))))))))))))))

(assert (= regexA (re.++ (re.++ (re.opt (re.range "#" "#"))(re.++ (re.+ (re.union (re.range "+" "+")(re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))))) (re.* (re.++ (re.range "." ".") (re.+ (re.union (re.range "+" "+")(re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z")))))))))))(re.++ (re.range "@" "@") (re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))(re.++ (re.* (re.++ (re.range "." ".") (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))))(re.++ (re.range "." ".") (re.union ((_ re.loop 1 3) (re.range "0" "9"))(re.union ((_ re.loop 2 3) (re.union (re.range "A" "Z") (re.range "a" "z"))) (re.union (str.to_re (str.++ "a" (str.++ "e" (str.++ "r" (str.++ "o" "")))))(re.union (str.to_re (str.++ "c" (str.++ "o" (str.++ "o" (str.++ "p" "")))))(re.union (str.to_re (str.++ "i" (str.++ "n" (str.++ "f" (str.++ "o" "")))))(re.union (str.to_re (str.++ "m" (str.++ "u" (str.++ "s" (str.++ "e" (str.++ "u" (str.++ "m" ""))))))) (str.to_re (str.++ "n" (str.++ "a" (str.++ "m" (str.++ "e" ""))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
