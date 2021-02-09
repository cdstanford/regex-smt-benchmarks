;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(?:[ -~]{10,25}(?:$|(?:[\w!?.])\s))
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "*,gdQ9N)W:>4"
(define-fun Witness1 () String (seq.++ "*" (seq.++ "," (seq.++ "g" (seq.++ "d" (seq.++ "Q" (seq.++ "9" (seq.++ "N" (seq.++ ")" (seq.++ "W" (seq.++ ":" (seq.++ ">" (seq.++ "4" "")))))))))))))
;witness2: "#2P B/8\'ag"
(define-fun Witness2 () String (seq.++ "#" (seq.++ "2" (seq.++ "P" (seq.++ " " (seq.++ "B" (seq.++ "/" (seq.++ "8" (seq.++ "'" (seq.++ "a" (seq.++ "g" "")))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 10 25) (re.range " " "~")) (re.union (str.to_re "") (re.++ (re.union (re.range "!" "!")(re.union (re.range "." ".")(re.union (re.range "0" "9")(re.union (re.range "?" "?")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))))) (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
