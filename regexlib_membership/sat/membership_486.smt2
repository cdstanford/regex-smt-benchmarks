;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [a-zA-Z0-9_\\-]+@([a-zA-Z0-9_\\-]+\\.)+(com)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "P@99\X4\\x1F9Q\(com"
(define-fun Witness1 () String (seq.++ "P" (seq.++ "@" (seq.++ "9" (seq.++ "9" (seq.++ "\x5c" (seq.++ "X" (seq.++ "4" (seq.++ "\x5c" (seq.++ "\x1f" (seq.++ "9" (seq.++ "Q" (seq.++ "\x5c" (seq.++ "(" (seq.++ "c" (seq.++ "o" (seq.++ "m" "")))))))))))))))))
;witness2: "\u00F4\u008D4@y\|Z\tn\e3d8g\\u008Bb\\u00B3comW"
(define-fun Witness2 () String (seq.++ "\xf4" (seq.++ "\x8d" (seq.++ "4" (seq.++ "@" (seq.++ "y" (seq.++ "\x5c" (seq.++ "|" (seq.++ "Z" (seq.++ "\x5c" (seq.++ "t" (seq.++ "n" (seq.++ "\x5c" (seq.++ "e" (seq.++ "3" (seq.++ "d" (seq.++ "8" (seq.++ "g" (seq.++ "\x5c" (seq.++ "\x8b" (seq.++ "b" (seq.++ "\x5c" (seq.++ "\xb3" (seq.++ "c" (seq.++ "o" (seq.++ "m" (seq.++ "W" "")))))))))))))))))))))))))))

(assert (= regexA (re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "\x5c" "\x5c")(re.union (re.range "_" "_") (re.range "a" "z")))))))(re.++ (re.range "@" "@")(re.++ (re.+ (re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "\x5c" "\x5c")(re.union (re.range "_" "_") (re.range "a" "z")))))))(re.++ (re.range "\x5c" "\x5c") (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))))) (str.to_re (seq.++ "c" (seq.++ "o" (seq.++ "m" "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
