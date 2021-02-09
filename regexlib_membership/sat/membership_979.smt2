;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(?<Drive>([a-zA-Z]:)|(\\{2}\w+)\$?)(\\(\w[\w].*))(?<Year>\d{4})-(?<Month>\d{1,2})-(?<Day>\d{1,2})(?<ExtraText>.*)(?<Extension>.csv|.CSV)$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "k:\1\u00B59979-8-8\u00C5csv"
(define-fun Witness1 () String (seq.++ "k" (seq.++ ":" (seq.++ "\x5c" (seq.++ "1" (seq.++ "\xb5" (seq.++ "9" (seq.++ "9" (seq.++ "7" (seq.++ "9" (seq.++ "-" (seq.++ "8" (seq.++ "-" (seq.++ "8" (seq.++ "\xc5" (seq.++ "c" (seq.++ "s" (seq.++ "v" ""))))))))))))))))))
;witness2: "\\1$\\u00F6\u00DA4756-90-9\u00C8CSV"
(define-fun Witness2 () String (seq.++ "\x5c" (seq.++ "\x5c" (seq.++ "1" (seq.++ "$" (seq.++ "\x5c" (seq.++ "\xf6" (seq.++ "\xda" (seq.++ "4" (seq.++ "7" (seq.++ "5" (seq.++ "6" (seq.++ "-" (seq.++ "9" (seq.++ "0" (seq.++ "-" (seq.++ "9" (seq.++ "\xc8" (seq.++ "C" (seq.++ "S" (seq.++ "V" "")))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.union (re.range "A" "Z") (re.range "a" "z")) (re.range ":" ":")) (re.++ (re.++ ((_ re.loop 2 2) (re.range "\x5c" "\x5c")) (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))) (re.opt (re.range "$" "$"))))(re.++ (re.++ (re.range "\x5c" "\x5c") (re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))(re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))) (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))))))(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 1 2) (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 1 2) (re.range "0" "9"))(re.++ (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))(re.++ (re.union (re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")) (str.to_re (seq.++ "c" (seq.++ "s" (seq.++ "v" ""))))) (re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")) (str.to_re (seq.++ "C" (seq.++ "S" (seq.++ "V" "")))))) (str.to_re "")))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
