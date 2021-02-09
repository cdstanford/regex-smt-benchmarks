;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([A-Za-z\-]+)\s+(\w+)\s+([A-Za-z0-9_\-\.]+)\s+([A-Za-z0-9_\-\.]+)\s+(\d+)\s+(.{3} [0-9 ]{2} ([0-9][0-9]:[0-9][0-9]| [0-9]{4}))\s+(.+)$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "-----Z\xC\u00AAK\u00A09A- 8-\xA\u00854\x9l\u0098\u00AD  8 29:56 \u00A0\u0083"
(define-fun Witness1 () String (seq.++ "-" (seq.++ "-" (seq.++ "-" (seq.++ "-" (seq.++ "-" (seq.++ "Z" (seq.++ "\x0c" (seq.++ "\xaa" (seq.++ "K" (seq.++ "\xa0" (seq.++ "9" (seq.++ "A" (seq.++ "-" (seq.++ " " (seq.++ "8" (seq.++ "-" (seq.++ "\x0a" (seq.++ "\x85" (seq.++ "4" (seq.++ "\x09" (seq.++ "l" (seq.++ "\x98" (seq.++ "\xad" (seq.++ " " (seq.++ " " (seq.++ "8" (seq.++ " " (seq.++ "2" (seq.++ "9" (seq.++ ":" (seq.++ "5" (seq.++ "6" (seq.++ " " (seq.++ "\xa0" (seq.++ "\x83" ""))))))))))))))))))))))))))))))))))))
;witness2: "----x \u0085\xB\u00A0\u0085\u00BA\xA. \u00A0\u00A0\u0085\u0085\xA\u0085z\x9 6 \u00A7(\u0080  8  8981\u0085\u00D8"
(define-fun Witness2 () String (seq.++ "-" (seq.++ "-" (seq.++ "-" (seq.++ "-" (seq.++ "x" (seq.++ " " (seq.++ "\x85" (seq.++ "\x0b" (seq.++ "\xa0" (seq.++ "\x85" (seq.++ "\xba" (seq.++ "\x0a" (seq.++ "." (seq.++ " " (seq.++ "\xa0" (seq.++ "\xa0" (seq.++ "\x85" (seq.++ "\x85" (seq.++ "\x0a" (seq.++ "\x85" (seq.++ "z" (seq.++ "\x09" (seq.++ " " (seq.++ "6" (seq.++ " " (seq.++ "\xa7" (seq.++ "(" (seq.++ "\x80" (seq.++ " " (seq.++ " " (seq.++ "8" (seq.++ " " (seq.++ " " (seq.++ "8" (seq.++ "9" (seq.++ "8" (seq.++ "1" (seq.++ "\x85" (seq.++ "\xd8" ""))))))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.+ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))(re.++ (re.+ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.+ (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))))(re.++ (re.+ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.+ (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))))(re.++ (re.+ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.+ (re.range "0" "9"))(re.++ (re.+ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.++ ((_ re.loop 3 3) (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))(re.++ (re.range " " " ")(re.++ ((_ re.loop 2 2) (re.union (re.range " " " ") (re.range "0" "9")))(re.++ (re.range " " " ") (re.union (re.++ (re.range "0" "9")(re.++ (re.range "0" "9")(re.++ (re.range ":" ":")(re.++ (re.range "0" "9") (re.range "0" "9"))))) (re.++ (re.range " " " ") ((_ re.loop 4 4) (re.range "0" "9"))))))))(re.++ (re.+ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.+ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))) (str.to_re "")))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
