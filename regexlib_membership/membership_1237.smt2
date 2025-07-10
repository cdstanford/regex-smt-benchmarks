;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(?:[ -~]{10,25}(?:$|(?:[\w!?.])\s))
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "*,gdQ9N)W:>4"
(define-fun Witness1 () String (str.++ "*" (str.++ "," (str.++ "g" (str.++ "d" (str.++ "Q" (str.++ "9" (str.++ "N" (str.++ ")" (str.++ "W" (str.++ ":" (str.++ ">" (str.++ "4" "")))))))))))))
;witness2: "#2P B/8\'ag"
(define-fun Witness2 () String (str.++ "#" (str.++ "2" (str.++ "P" (str.++ " " (str.++ "B" (str.++ "/" (str.++ "8" (str.++ "'" (str.++ "a" (str.++ "g" "")))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 10 25) (re.range " " "~")) (re.union (str.to_re "") (re.++ (re.union (re.range "!" "!")(re.union (re.range "." ".")(re.union (re.range "0" "9")(re.union (re.range "?" "?")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))))) (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
