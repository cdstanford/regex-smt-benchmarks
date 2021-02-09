;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (?:(?<scheme>[a-zA-Z]+)://)?(?<domain>(?:[0-9a-zA-Z\-_]+(?:[.][0-9a-zA-Z\-_]+)*))(?::(?<port>[0-9]+))?(?<path>(?:/[0-9a-zA-Z\-_.]+)+)(?:[?](?<query>.+))?
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "DtXfeZCLe://U.-/gJ/MU6.?/UX"
(define-fun Witness1 () String (seq.++ "D" (seq.++ "t" (seq.++ "X" (seq.++ "f" (seq.++ "e" (seq.++ "Z" (seq.++ "C" (seq.++ "L" (seq.++ "e" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "U" (seq.++ "." (seq.++ "-" (seq.++ "/" (seq.++ "g" (seq.++ "J" (seq.++ "/" (seq.++ "M" (seq.++ "U" (seq.++ "6" (seq.++ "." (seq.++ "?" (seq.++ "/" (seq.++ "U" (seq.++ "X" ""))))))))))))))))))))))))))))
;witness2: "--:239/z?\x7"
(define-fun Witness2 () String (seq.++ "-" (seq.++ "-" (seq.++ ":" (seq.++ "2" (seq.++ "3" (seq.++ "9" (seq.++ "/" (seq.++ "z" (seq.++ "?" (seq.++ "\x07" "")))))))))))

(assert (= regexA (re.++ (re.opt (re.++ (re.+ (re.union (re.range "A" "Z") (re.range "a" "z"))) (str.to_re (seq.++ ":" (seq.++ "/" (seq.++ "/" ""))))))(re.++ (re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z")))))) (re.* (re.++ (re.range "." ".") (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z")))))))))(re.++ (re.opt (re.++ (re.range ":" ":") (re.+ (re.range "0" "9"))))(re.++ (re.+ (re.++ (re.range "/" "/") (re.+ (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z")))))))) (re.opt (re.++ (re.range "?" "?") (re.+ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
