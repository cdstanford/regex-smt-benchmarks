;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[http|ftp|wap|https]{3,5}:\//\www\.\w*\.[com|net]{2,3}$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "h|s://\u00EDww.\u00C249\u00B5z.||n"
(define-fun Witness1 () String (str.++ "h" (str.++ "|" (str.++ "s" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "\u{ed}" (str.++ "w" (str.++ "w" (str.++ "." (str.++ "\u{c2}" (str.++ "4" (str.++ "9" (str.++ "\u{b5}" (str.++ "z" (str.++ "." (str.++ "|" (str.++ "|" (str.++ "n" ""))))))))))))))))))))
;witness2: "aaf://nww.\u00FE.oot"
(define-fun Witness2 () String (str.++ "a" (str.++ "a" (str.++ "f" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "n" (str.++ "w" (str.++ "w" (str.++ "." (str.++ "\u{fe}" (str.++ "." (str.++ "o" (str.++ "o" (str.++ "t" ""))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 3 5) (re.union (re.range "a" "a")(re.union (re.range "f" "f")(re.union (re.range "h" "h")(re.union (re.range "p" "p")(re.union (re.range "s" "t")(re.union (re.range "w" "w") (re.range "|" "|"))))))))(re.++ (str.to_re (str.++ ":" (str.++ "/" (str.++ "/" ""))))(re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))(re.++ (str.to_re (str.++ "w" (str.++ "w" (str.++ "." ""))))(re.++ (re.* (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))(re.++ (re.range "." ".")(re.++ ((_ re.loop 2 3) (re.union (re.range "c" "c")(re.union (re.range "e" "e")(re.union (re.range "m" "o")(re.union (re.range "t" "t") (re.range "|" "|")))))) (str.to_re "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
