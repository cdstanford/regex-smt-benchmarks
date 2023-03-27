;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (?:(?<scheme>[a-zA-Z]+)://)?(?<domain>(?:[0-9a-zA-Z\-_]+(?:[.][0-9a-zA-Z\-_]+)*))(?::(?<port>[0-9]+))?(?<path>(?:/[0-9a-zA-Z\-_.]+)+)(?:[?](?<query>.+))?
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "DtXfeZCLe://U.-/gJ/MU6.?/UX"
(define-fun Witness1 () String (str.++ "D" (str.++ "t" (str.++ "X" (str.++ "f" (str.++ "e" (str.++ "Z" (str.++ "C" (str.++ "L" (str.++ "e" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "U" (str.++ "." (str.++ "-" (str.++ "/" (str.++ "g" (str.++ "J" (str.++ "/" (str.++ "M" (str.++ "U" (str.++ "6" (str.++ "." (str.++ "?" (str.++ "/" (str.++ "U" (str.++ "X" ""))))))))))))))))))))))))))))
;witness2: "--:239/z?\x7"
(define-fun Witness2 () String (str.++ "-" (str.++ "-" (str.++ ":" (str.++ "2" (str.++ "3" (str.++ "9" (str.++ "/" (str.++ "z" (str.++ "?" (str.++ "\u{07}" "")))))))))))

(assert (= regexA (re.++ (re.opt (re.++ (re.+ (re.union (re.range "A" "Z") (re.range "a" "z"))) (str.to_re (str.++ ":" (str.++ "/" (str.++ "/" ""))))))(re.++ (re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z")))))) (re.* (re.++ (re.range "." ".") (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z")))))))))(re.++ (re.opt (re.++ (re.range ":" ":") (re.+ (re.range "0" "9"))))(re.++ (re.+ (re.++ (re.range "/" "/") (re.+ (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z")))))))) (re.opt (re.++ (re.range "?" "?") (re.+ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
