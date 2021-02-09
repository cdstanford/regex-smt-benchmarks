;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (<meta\s+)*((name\s*=\s*("|')(?<name>[^'("|')]*)("|')){1}|content\s*=\s*("|')(?<content>[^'("|')]*)("|')|scheme\s*=\s*("|')(?<scheme>[^'("|')]*)("|'))
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "content\u0085=  \x9\u0085\u00A0\xB\xA\x9\'\"\u00B20\x1D\u00DCQ"
(define-fun Witness1 () String (seq.++ "c" (seq.++ "o" (seq.++ "n" (seq.++ "t" (seq.++ "e" (seq.++ "n" (seq.++ "t" (seq.++ "\x85" (seq.++ "=" (seq.++ " " (seq.++ " " (seq.++ "\x09" (seq.++ "\x85" (seq.++ "\xa0" (seq.++ "\x0b" (seq.++ "\x0a" (seq.++ "\x09" (seq.++ "'" (seq.++ "\x22" (seq.++ "\xb2" (seq.++ "0" (seq.++ "\x1d" (seq.++ "\xdc" (seq.++ "Q" "")))))))))))))))))))))))))
;witness2: "&\u00A4<meta\u0085name\u0085= \u0085\'\u00A3\"\u00FA"
(define-fun Witness2 () String (seq.++ "&" (seq.++ "\xa4" (seq.++ "<" (seq.++ "m" (seq.++ "e" (seq.++ "t" (seq.++ "a" (seq.++ "\x85" (seq.++ "n" (seq.++ "a" (seq.++ "m" (seq.++ "e" (seq.++ "\x85" (seq.++ "=" (seq.++ " " (seq.++ "\x85" (seq.++ "'" (seq.++ "\xa3" (seq.++ "\x22" (seq.++ "\xfa" "")))))))))))))))))))))

(assert (= regexA (re.++ (re.* (re.++ (str.to_re (seq.++ "<" (seq.++ "m" (seq.++ "e" (seq.++ "t" (seq.++ "a" "")))))) (re.+ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))))) (re.union (re.++ (str.to_re (seq.++ "n" (seq.++ "a" (seq.++ "m" (seq.++ "e" "")))))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.range "=" "=")(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.union (re.range "\x22" "\x22") (re.range "'" "'"))(re.++ (re.* (re.union (re.range "\x00" "!")(re.union (re.range "#" "&")(re.union (re.range "*" "{") (re.range "}" "\xff"))))) (re.union (re.range "\x22" "\x22") (re.range "'" "'"))))))))(re.union (re.++ (str.to_re (seq.++ "c" (seq.++ "o" (seq.++ "n" (seq.++ "t" (seq.++ "e" (seq.++ "n" (seq.++ "t" ""))))))))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.range "=" "=")(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.union (re.range "\x22" "\x22") (re.range "'" "'"))(re.++ (re.* (re.union (re.range "\x00" "!")(re.union (re.range "#" "&")(re.union (re.range "*" "{") (re.range "}" "\xff"))))) (re.union (re.range "\x22" "\x22") (re.range "'" "'")))))))) (re.++ (str.to_re (seq.++ "s" (seq.++ "c" (seq.++ "h" (seq.++ "e" (seq.++ "m" (seq.++ "e" "")))))))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.range "=" "=")(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.union (re.range "\x22" "\x22") (re.range "'" "'"))(re.++ (re.* (re.union (re.range "\x00" "!")(re.union (re.range "#" "&")(re.union (re.range "*" "{") (re.range "}" "\xff"))))) (re.union (re.range "\x22" "\x22") (re.range "'" "'")))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
