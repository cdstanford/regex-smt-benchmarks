;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(?<Drive>([a-zA-Z]:)|(\\{2}\w+)\$?)(\\(\w[\w].*))(?<Year>\d{4})-(?<Month>\d{1,2})-(?<Day>\d{1,2})(?<ExtraText>.*)(?<Extension>.csv|.CSV)$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "k:\1\u00B59979-8-8\u00C5csv"
(define-fun Witness1 () String (str.++ "k" (str.++ ":" (str.++ "\u{5c}" (str.++ "1" (str.++ "\u{b5}" (str.++ "9" (str.++ "9" (str.++ "7" (str.++ "9" (str.++ "-" (str.++ "8" (str.++ "-" (str.++ "8" (str.++ "\u{c5}" (str.++ "c" (str.++ "s" (str.++ "v" ""))))))))))))))))))
;witness2: "\\1$\\u00F6\u00DA4756-90-9\u00C8CSV"
(define-fun Witness2 () String (str.++ "\u{5c}" (str.++ "\u{5c}" (str.++ "1" (str.++ "$" (str.++ "\u{5c}" (str.++ "\u{f6}" (str.++ "\u{da}" (str.++ "4" (str.++ "7" (str.++ "5" (str.++ "6" (str.++ "-" (str.++ "9" (str.++ "0" (str.++ "-" (str.++ "9" (str.++ "\u{c8}" (str.++ "C" (str.++ "S" (str.++ "V" "")))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.union (re.range "A" "Z") (re.range "a" "z")) (re.range ":" ":")) (re.++ (re.++ ((_ re.loop 2 2) (re.range "\u{5c}" "\u{5c}")) (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))) (re.opt (re.range "$" "$"))))(re.++ (re.++ (re.range "\u{5c}" "\u{5c}") (re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))(re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))) (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))))))(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 1 2) (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 1 2) (re.range "0" "9"))(re.++ (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))(re.++ (re.union (re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")) (str.to_re (str.++ "c" (str.++ "s" (str.++ "v" ""))))) (re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")) (str.to_re (str.++ "C" (str.++ "S" (str.++ "V" "")))))) (str.to_re "")))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
